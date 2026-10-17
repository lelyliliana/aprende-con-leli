"""Pruebas HTTP locales; solo biblioteca estándar Python. Base y sesiones aisladas."""
from pathlib import Path
import http.cookiejar
import json
import os
import re
import socket
import subprocess
import tempfile
import time
import urllib.error
import urllib.parse
import urllib.request

ROOT = Path(__file__).resolve().parents[1]
PHP = os.environ.get("PHP_BINARY", "php")
count = 0

def check(condition, message):
    global count
    if not condition:
        raise AssertionError(message)
    count += 1

with tempfile.TemporaryDirectory(prefix="leli-php-") as tmp:
    env = dict(os.environ, APP_DB=str(Path(tmp) / "test.sqlite"), APP_ENV="production", APP_HTTPS="0")
    subprocess.run([PHP, str(ROOT / "proyecto/bin/inicializar.php")], env=env, check=True, capture_output=True)
    subprocess.run([PHP, str(ROOT / "proyecto/bin/crear_usuario.php"), "docente"], input="clave-local-de-prueba\n", text=True, env=env, check=True, capture_output=True)
    # Elegir puerto local disponible; el servidor nunca escucha en todas las interfaces.
    with socket.socket() as sock:
        sock.bind(("127.0.0.1", 0))
        port = sock.getsockname()[1]
    origin = f"http://127.0.0.1:{port}"
    jar = http.cookiejar.CookieJar()
    client = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(jar))
    anon = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(http.cookiejar.CookieJar()))
    def request(path="/", data=None, method=None, opener=client):
        body = urllib.parse.urlencode(data).encode() if data is not None else None
        req = urllib.request.Request(origin + path, data=body, method=method)
        try:
            with opener.open(req, timeout=5) as res:
                return res.status, res.read().decode(), res.headers
        except urllib.error.HTTPError as error:
            return error.code, error.read().decode(), error.headers
    def token(body):
        match = re.search(r'name="csrf" value="([a-f0-9]+)"', body)
        check(match is not None, "Falta token en formulario")
        return match.group(1)
    with open(Path(tmp) / "server.log", "w+") as log:
        process = subprocess.Popen([PHP, "-d", f"session.save_path={tmp}", "-S", f"127.0.0.1:{port}", "-t", str(ROOT / "proyecto/public")], env=env, stdout=log, stderr=log)
        try:
            for attempt in range(50):
                try:
                    status, body, headers = request()
                    break
                except (urllib.error.URLError, ConnectionError):
                    if process.poll() is not None:
                        log.seek(0)
                        raise RuntimeError(log.read())
                    time.sleep(.1)
            else:
                raise RuntimeError("El servidor local no inició")
            check(status == 200 and "Iniciar sesión" in body, "No muestra acceso")
            check("HttpOnly" in headers.get("Set-Cookie", "") and "SameSite=Lax" in headers.get("Set-Cookie", ""), "Cookie sin atributos")
            csrf = token(body)
            check(request('/api/talleres')[0] == 401, "API pública por accidente")
            check(request(data={"accion": "crear", "titulo": "PHP", "cupo": "12", "csrf": csrf})[0] == 401, "Escritura sin sesión")
            check(request(data={"accion": "entrar", "nombre": "docente", "clave": "mal", "csrf": csrf})[0] == 401, "Login inválido aceptado")
            old_session = next(c.value for c in jar if c.name == 'leli_talleres')
            status, body, _ = request(data={"accion": "entrar", "nombre": "docente", "clave": "clave-local-de-prueba", "csrf": csrf})
            check(status == 200 and "Crear taller" in body, "No inicia sesión")
            check(next(c.value for c in jar if c.name == 'leli_talleres') != old_session, "No renueva ID de sesión")
            csrf = token(body)
            check(request(data={"accion": "crear", "titulo": "PHP", "cupo": "12", "csrf": "incorrecto"})[0] == 403, "Aceptó CSRF inválido")
            check(request(data={"accion": "crear", "titulo": "ab", "cupo": "0", "csrf": csrf})[0] == 422, "Aceptó dominio inválido")
            check(request(data={"accion": "crear", "titulo[]": "PHP", "cupo[]": "12", "csrf": csrf})[0] == 422, "Aceptó arreglos como campos")
            check(json.loads(request('/api/talleres')[1])['total'] == 0, "Los rechazos cambiaron la base")
            title = '<script>alert(1)</script>'
            status, body, _ = request(data={"accion": "crear", "titulo": title, "cupo": "12", "csrf": csrf})
            check(status == 200 and '&lt;script&gt;alert(1)&lt;/script&gt;' in body and title not in body, "Salida HTML sin escape")
            check('Taller guardado.' in body and 'Taller guardado.' not in request()[1], "Flash no se consume")
            status, text, headers = request('/api/talleres')
            payload = json.loads(text)
            check(status == 200 and headers.get_content_type() == 'application/json', "Respuesta API incorrecta")
            check(payload['total'] == 1 and payload['data'][0]['titulo'] == title, "API y base difieren")
            check(set(payload['data'][0]) == {'id', 'titulo', 'cupo'}, "API revela columnas adicionales")
            workshop_id = payload['data'][0]['id']
            check(request(f'/?editar={workshop_id}')[0] == 200, "No abre edición")
            status, body, _ = request(data={"accion": "editar", "id": workshop_id, "titulo": "PHP actualizado", "cupo": "20", "csrf": csrf})
            check(status == 200 and 'PHP actualizado' in body, "No guarda edición")
            check(request(data={"accion": "editar", "id": "99999", "titulo": "PHP", "cupo": "12", "csrf": csrf})[0] == 404, "Edita inexistente")
            check(request(data={"accion": "eliminar", "id": "0", "csrf": csrf})[0] == 400, "Acepta ID inválido")
            for path in ['/api/talleres?page=0', '/api/talleres?page[]=1', '/?q[]=php']:
                check(request(path)[0] == 400, "Acepta filtro/página inválidos")
            check(json.loads(request('/api/talleres?q=' + urllib.parse.quote("' OR 1=1 --"))[1])['total'] == 0, "Búsqueda interpreta SQL")
            check(request('/api/talleres', method='POST', data={})[0] == 405, "API admite escritura")
            check(request('/', method='DELETE')[0] == 405, "Método no permitido aceptado")
            check(request('/no-existe')[0] == 404, "Ruta desconocida sin 404")
            check(request('/src/bootstrap.php')[0] == 404 and request('/var/talleres.sqlite')[0] == 404, "Raíz pública expone código o base")
            for i in range(11):
                check(request(data={"accion": "crear", "titulo": f"Taller {i}", "cupo": "5", "csrf": csrf})[0] == 200, "Crear para paginación falla")
            first = json.loads(request('/api/talleres')[1]); second = json.loads(request('/api/talleres?page=2')[1])
            check(first['total'] == 12 and len(first['data']) == 10 and len(second['data']) == 2, "Paginación HTTP incorrecta")
            check(not ({x['id'] for x in first['data']} & {x['id'] for x in second['data']}), "Paginación repite IDs")
            check(request(data={"accion": "eliminar", "id": workshop_id, "csrf": csrf})[0] == 200, "No elimina")
            check(request(data={"accion": "eliminar", "id": workshop_id, "csrf": csrf})[0] == 404, "Borrado inexistente sin 404")
            check(request('/api/talleres', opener=anon)[0] == 401, "Otra sesión hereda el acceso")
            check(request(data={"accion": "salir", "csrf": csrf})[0] == 200, "Salir falla")
            check(request('/api/talleres')[0] == 401, "Conserva acceso tras salir")
            # Reabrir el archivo confirma persistencia sin depender de la conexión HTTP.
            result = subprocess.run([PHP, '-r', 'require $argv[1]; echo (new Aprende\\TallerRepository(conectar()))->contar();', str(ROOT / 'proyecto/src/bootstrap.php')], env=env, text=True, capture_output=True, check=True)
            check(result.stdout == '11', "La base no conserva los cambios")
            print(f"{count} comprobaciones HTTP correctas; base y sesiones temporales eliminadas.")
        finally:
            process.terminate()
            try:
                process.wait(timeout=5)
            except subprocess.TimeoutExpired:
                process.kill()
                process.wait()
