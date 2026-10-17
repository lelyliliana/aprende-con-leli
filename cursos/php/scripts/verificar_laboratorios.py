"""Pruebas de laboratorios con HTTP real y sesiones aisladas; sin paquetes externos."""
from contextlib import contextmanager
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
PHP = os.environ.get('PHP_BINARY', 'php')
checks = 0


def check(condition, message):
    global checks
    if not condition:
        raise AssertionError(message)
    checks += 1


class Redirects(urllib.request.HTTPRedirectHandler):
    def __init__(self):
        self.codes = []

    def redirect_request(self, req, fp, code, msg, headers, newurl):
        self.codes.append(code)
        return super().redirect_request(req, fp, code, msg, headers, newurl)


class Client:
    def __init__(self, origin):
        self.origin = origin
        self.jar = http.cookiejar.CookieJar()
        self.redirects = Redirects()
        self.opener = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(self.jar), self.redirects)

    def call(self, path='/', data=None, raw=None, content_type=None, method=None):
        self.redirects.codes.clear()
        body = urllib.parse.urlencode(data).encode() if data is not None else raw
        headers = {} if content_type is None else {'Content-Type': content_type}
        request = urllib.request.Request(self.origin + path, data=body, method=method, headers=headers)
        try:
            with self.opener.open(request, timeout=5) as result:
                return result.status, result.read().decode(), result.headers
        except urllib.error.HTTPError as error:
            return error.code, error.read().decode(), error.headers

    def json(self, path, value):
        return self.call(path, raw=json.dumps(value).encode(), content_type='application/json')


def token(body):
    result = re.search(r'name="csrf" value="([a-f0-9]+)"', body)
    check(result is not None, 'Falta token de formulario')
    return result.group(1)


def ids(body):
    return set(re.findall(r'<li data-id="(\d+)">', body))


@contextmanager
def server(lab):
    with tempfile.TemporaryDirectory(prefix='leli-lab-') as tmp:
        with socket.socket() as sock:
            sock.bind(('127.0.0.1', 0))
            port = sock.getsockname()[1]
        origin = f'http://127.0.0.1:{port}'
        with open(Path(tmp) / 'server.log', 'w+') as log:
            process = subprocess.Popen([PHP, '-d', f'session.save_path={tmp}', '-S', f'127.0.0.1:{port}', '-t', str(ROOT / 'laboratorios' / lab / 'public')], stdout=log, stderr=log)
            try:
                client = Client(origin)
                for _ in range(60):
                    try:
                        client.call()
                        break
                    except (urllib.error.URLError, ConnectionError):
                        if process.poll() is not None:
                            log.seek(0)
                            raise RuntimeError(log.read())
                        time.sleep(.05)
                else:
                    raise RuntimeError(f'No inició {lab}')
                yield client
                log.flush()
                log.seek(0)
                text = log.read()
                check('Fatal error' not in text and 'Warning:' not in text and 'Deprecated:' not in text, f'Diagnóstico PHP inesperado en {lab}: {text}')
            finally:
                process.terminate()
                try:
                    process.wait(timeout=5)
                except subprocess.TimeoutExpired:
                    process.kill()
                    process.wait()


with server('09-http') as client:
    status, body, headers = client.call()
    check(status == 200 and 'Hola, estudiante' in body and headers.get_content_type() == 'text/html', 'GET inicial incorrecto')
    status, body, _ = client.call('/?nombre=' + urllib.parse.quote('<b>Ana & Luis</b>'))
    check(status == 200 and '&lt;b&gt;Ana &amp; Luis&lt;/b&gt;' in body and '<b>Ana' not in body, 'Saludo sin escape')
    check(client.call('/?nombre[]=PHP')[0] == 400, 'Acepta nombre como arreglo')
    check(client.call('/?nombre=' + 'a' * 80)[0] == 200, 'Rechaza longitud 80')
    check(client.call('/?nombre=' + 'a' * 81)[0] == 400, 'Acepta longitud 81')
    status, _, headers = client.call(data={})
    check(status == 405 and headers.get('Allow') == 'GET', 'Método incorrecto sin 405/Allow')

with server('10-formularios') as client:
    check(client.call()[0] == 200, 'No muestra formulario')
    status, body, _ = client.call(data={'titulo': ' PHP ', 'cupo': '1'})
    check(status == 200 and 'Datos válidos: PHP' in body and 'No se guardó información.' in body, 'No valida el caso normal')
    status, body, _ = client.call(data={'titulo': 'PHP', 'cupo': '0'})
    check(status == 422 and 'value="PHP"' in body and 'aria-describedby="error-cupo"' in body, 'No conserva campo/asocia error')
    check(client.call(data={'titulo[]': 'PHP', 'cupo[]': '12'})[0] == 422, 'Arreglos aceptados en formulario')
    check(client.call(data={'titulo': 'ó' * 100, 'cupo': '100'})[0] == 200, 'Rechaza límite Unicode válido')
    check(client.call(data={'titulo': 'a' * 101, 'cupo': '12'})[0] == 422, 'Acepta título de 101')
    status, body, _ = client.call(data={'titulo': '<b>PHP</b>', 'cupo': '12'})
    check(status == 200 and '&lt;b&gt;PHP&lt;/b&gt;' in body and '<b>PHP</b>' not in body, 'Formulario sin escape')
    check('Datos válidos:' not in client.call()[1], 'Formulario conserva estado no previsto')
    check(client.call(method='DELETE')[0] == 405, 'Formulario admite DELETE')

with server('11-sesiones') as client:
    status, body, _ = client.call()
    csrf = token(body)
    check(status == 200 and 'Sin nota' in body, 'Sesión no comienza vacía')
    cookie = next(cookie for cookie in client.jar if cookie.name == 'leli_lab_notas')
    check(cookie.has_nonstandard_attr('HttpOnly') and cookie.get_nonstandard_attr('SameSite') == 'Lax', 'Cookie de laboratorio incorrecta')
    status, body, _ = client.call(data={'csrf': csrf, 'nota': 'Preparar sensores'})
    check(status == 200 and client.redirects.codes == [303], 'Nota no redirige con 303')
    check('Nota guardada en esta sesión.' in body and '<strong>Preparar sensores</strong>' in body, 'No conserva nota/flash')
    check('Nota guardada en esta sesión.' not in client.call()[1], 'Flash se repite')
    check(client.call(data={'csrf': 'otro', 'nota': 'Alterada'})[0] == 403, 'Token incorrecto aceptado')
    check(client.call(data={'nota': 'Alterada'})[0] == 403, 'Token ausente aceptado')
    check('<strong>Preparar sensores</strong>' in client.call()[1], 'Rechazo modificó nota')
    check(client.call(data={'csrf': csrf, 'nota': ''})[0] == 422, 'Nota vacía aceptada')
    check(client.call(data={'csrf': csrf, 'nota[]': 'valor'})[0] == 422, 'Nota como arreglo aceptada')
    status, body, _ = client.call(data={'csrf': csrf, 'nota': '<b>Práctica</b>'})
    check(status == 200 and '<strong>&lt;b&gt;Práctica&lt;/b&gt;</strong>' in body, 'Nota sin escape')
    check('Sin nota' in Client(client.origin).call()[1], 'Otra sesión hereda nota')

with server('13-crud') as client:
    status, body, _ = client.call()
    csrf = token(body)
    check(status == 200 and ids(body) == set(), 'CRUD no inicia vacío')
    check(client.call(data={'csrf': 'otro', 'accion': 'crear', 'titulo': 'PHP', 'cupo': '12'})[0] == 403, 'CRUD sin CSRF')
    check(client.call(data={'csrf': csrf, 'accion': 'crear', 'titulo[]': 'PHP', 'cupo': '12'})[0] == 422, 'CRUD acepta arreglo')
    for n in range(12):
        status, body, _ = client.call(data={'csrf': csrf, 'accion': 'crear', 'titulo': f'Taller {n:02d}', 'cupo': '12'})
        check(status == 200 and client.redirects.codes == [303], 'Alta CRUD sin redirección')
    first = ids(body)
    second = ids(client.call('/?page=2')[1])
    check(len(first) == 10 and len(second) == 2 and not first & second, 'Paginación de colección falla')
    check(ids(client.call('/?q=Taller+00')[1]) == {'1'}, 'Filtro no conserva identidad')
    check(client.call('/?q[]=PHP')[0] == 400, 'Filtro como arreglo aceptado')
    check(client.call('/?page=0')[0] == 400, 'Página cero aceptada')
    check(client.call('/?editar=999')[0] == 404, 'Edición inexistente disponible')
    check(client.call(data={'csrf': csrf, 'accion': 'editar', 'id': '999', 'titulo': 'Otro', 'cupo': '12'})[0] == 404, 'Edición crea inexistente')
    status, body, _ = client.call(data={'csrf': csrf, 'accion': 'editar', 'id': '1', 'titulo': '<b>Revisado</b>', 'cupo': '20'})
    edited = client.call('/?q=Revisado')[1]
    check(status == 200 and '&lt;b&gt;Revisado&lt;/b&gt;' in edited and '<b>Revisado</b>' not in edited and ids(edited) == {'1'}, 'Edición cambia ID o no escapa')
    check(client.call(data={'csrf': csrf, 'accion': 'eliminar', 'id': '0'})[0] == 400, 'ID cero aceptado')
    check(client.call(data={'csrf': csrf, 'accion': 'eliminar', 'id': '1'})[0] == 200, 'No elimina')
    check(ids(client.call('/?q=Revisado')[1]) == set(), 'Borrado deja fila')
    check(client.call(data={'csrf': csrf, 'accion': 'eliminar', 'id': '1'})[0] == 404, 'Borrado inexistente anuncia éxito')
    check(ids(Client(client.origin).call()[1]) == set(), 'Colección heredada por otro perfil')
    status, body, _ = client.call(data={'csrf': csrf, 'accion': 'crear', 'titulo': 'ID siguiente', 'cupo': '12'})
    check('13' in ids(body), 'Reutiliza un ID borrado')

with server('17-api') as client:
    status, body, headers = client.call('/talleres')
    payload = json.loads(body)
    check(status == 200 and headers.get_content_type() == 'application/json' and payload['total'] == 2, 'API de laboratorio incorrecta')
    selected = json.loads(client.call('/talleres?q=html')[1])
    check(isinstance(selected['data'], list) and len(selected['data']) == 1 and selected['data'][0]['id'] == 2, 'Filtro pierde lista JSON')
    check(json.loads(client.call('/talleres?q=ausente')[1])['data'] == [], 'Sin coincidencias no es lista vacía')
    check(client.call('/talleres?q[]=PHP')[0] == 400, 'Filtro inválido aceptado')
    status, _, headers = client.call('/talleres', data={})
    check(status == 405 and headers.get('Allow') == 'GET', 'Método lista incorrecto')
    check(client.call('/validar')[0] == 405, 'GET validación aceptado')
    check(client.call('/validar', data={'titulo': 'PHP', 'cupo': '12'})[0] == 415, 'Tipo de contenido no comprobado')
    check(client.call('/validar', raw=b'{mal}', content_type='application/json')[0] == 400, 'JSON inválido aceptado')
    for value in [[], None, {}, {'titulo': 'PHP', 'cupo': '12'}, {'titulo': [], 'cupo': 12}, {'titulo': 'PHP', 'cupo': 0}, {'titulo': 'PHP', 'cupo': 101}]:
        check(client.json('/validar', value)[0] == 422, f'Estructura/dominio aceptado: {value}')
    status, body, _ = client.json('/validar', {'titulo': ' PHP ', 'cupo': 12})
    check(status == 200 and json.loads(body) == {'data': {'titulo': 'PHP', 'cupo': 12}, 'persistido': False}, 'Normalización JSON incorrecta')
    check(client.call('/validar', raw=b' ' * 4097, content_type='application/json')[0] == 413, 'No limita cuerpo')
    check(json.loads(client.call('/talleres')[1])['total'] == 2, 'La validación alteró datos ficticios')
    check(client.call('/desconocida')[0] == 404, 'Ruta inexistente sin 404')

print(f'{checks} comprobaciones de laboratorios correctas; servidores y sesiones temporales cerrados.')
