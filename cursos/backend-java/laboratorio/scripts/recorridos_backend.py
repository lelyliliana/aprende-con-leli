"""Experimentos Backend contra los JAR de la revisión pública indicada."""
import argparse
import contextlib
import importlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile
from threading import Thread
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

REVISION = '16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11'


def cargar(ruta):
    raiz = ruta.resolve()
    revision = subprocess.check_output(['git', '-C', str(raiz), 'rev-parse', 'HEAD'], text=True).strip()
    if revision != REVISION:
        raise RuntimeError('Usa una copia de práctica en la revisión ' + REVISION)
    sys.path.insert(0, str(raiz / 'scripts'))
    guia = importlib.import_module('recorridos')
    verificar = importlib.import_module('verificar')
    peticion = importlib.import_module('peticion')
    return raiz, guia.Recorrido, verificar.aplicacion, verificar.base_env, peticion.cliente


@contextlib.contextmanager
def proveedor_local():
    # Cada escenario reinicia el contador; no hay peticiones concurrentes a este proveedor.
    estado = {'modo': 'valido', 'llamadas': 0}

    class Handler(BaseHTTPRequestHandler):
        def do_GET(self):
            estado['llamadas'] += 1
            modo = estado['modo']
            sku = self.path.rsplit('/', 1)[-1]
            status, cuerpo = 200, {'sku': sku, 'precio': 75}
            if modo == 'otro-sku':
                cuerpo['sku'] = 'OTRO'
            elif modo in ('ausente', 'limite', 'caido'):
                status = {'ausente': 404, 'limite': 429, 'caido': 503}[modo]
            elif modo == 'transitorio' and estado['llamadas'] == 1:
                status = 503
            datos = b'JSON roto' if modo == 'json-roto' else json.dumps(cuerpo).encode('utf-8')
            self.send_response(status)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Content-Length', str(len(datos)))
            self.end_headers()
            self.wfile.write(datos)

        def log_message(self, *_args):
            pass

    servidor = ThreadingHTTPServer(('127.0.0.1', 0), Handler)
    hilo = Thread(target=servidor.serve_forever, daemon=True)
    hilo.start()
    try:
        yield 'http://127.0.0.1:' + str(servidor.server_port), estado
    finally:
        servidor.shutdown()
        servidor.server_close()
        hilo.join()


def rest(h, salida):
    _raiz, Recorrido, aplicacion, _env, cliente = h
    with aplicacion('laboratorios/rest-memoria', {}, 'backend-rest', aislar=True) as base:
        r = Recorrido(base)
        sesion = cliente()
        a = {'sku': 'BACK-A', 'nombre': 'Material inicial', 'precio': 10}
        b = {'sku': 'BACK-B', 'nombre': 'Material adicional', 'precio': 20}
        r.caso('REST: un rechazo conserva el recurso anterior')
        headers, original = r.pedir(sesion, '/api/productos', 'POST', a, 201)
        ruta = '/api/productos/' + str(original['id'])
        r.comprobar(headers['Location'].endswith(ruta), 'Location de A')
        _, segundo = r.pedir(sesion, '/api/productos', 'POST', b, 201)
        r.pedir(sesion, ruta, 'PUT', {**a, 'sku': b['sku'], 'precio': 99}, 409)
        _, conservado = r.pedir(sesion, ruta)
        r.comprobar(conservado == original, 'El rechazo no cambia ningún campo de A')
        _, error = r.pedir(sesion, '/api/productos', 'POST', {**a, 'precio': 1.001}, 400)
        r.comprobar(error['code'] == 'VALIDATION_ERROR', 'El precio falla antes de unicidad')
        r.caso('REST: filtro, página vacía y eliminación sin cuerpo')
        _, pagina = r.pedir(sesion, '/api/productos?nombre=material&pagina=2&tamano=1')
        r.comprobar(pagina['total'] == 2 and pagina['contenido'] == [], 'Total distinto de contenido')
        _, actualizado = r.pedir(sesion, ruta, 'PUT', {**a, 'precio': 15})
        r.comprobar(actualizado['precio'] == 15 and 'version' not in actualizado, 'Contrato REST')
        borrado = '/api/productos/' + str(segundo['id'])
        _, cuerpo = r.pedir(sesion, borrado, 'DELETE', status=204)
        r.comprobar(cuerpo is None, '204 sin JSON')
        r.pedir(sesion, borrado, status=404)
        salida.append(r)
    with aplicacion('laboratorios/rest-memoria', {}, 'backend-rest-reinicio', aislar=True) as base:
        r = Recorrido(base)
        r.caso('REST: reiniciar elimina el mapa')
        _, pagina = r.pedir(cliente(), '/api/productos')
        r.comprobar(pagina['total'] == 0, 'Un proceso nuevo no conserva el mapa')
        salida.append(r)


def persistencia(h, salida):
    _raiz, Recorrido, aplicacion, _env, cliente = h
    with tempfile.TemporaryDirectory(prefix='leli-backend-') as carpeta:
        url = 'jdbc:h2:file:' + (Path(carpeta) / 'catalogo').as_posix() + ';MODE=PostgreSQL'
        args = ('--spring.datasource.url=' + url,)
        env = {'SPRING_PROFILES_ACTIVE': 'dev'}
        with aplicacion('laboratorios/jpa-productos', env, 'backend-archivo', args, aislar=True) as base:
            r = Recorrido(base)
            sesion = cliente()
            r.caso('JPA: versión y dato conservado en base de archivo')
            _, categorias = r.pedir(sesion, '/api/categorias')
            entrada = {'sku': 'BACK-DUR', 'nombre': 'Material durable', 'precio': 10,
                       'categoriaId': categorias[0]['id']}
            _, producto = r.pedir(sesion, '/api/productos', 'POST', entrada, 201)
            ruta = '/api/productos/' + str(producto['id'])
            _, valido = r.pedir(sesion, ruta, 'PUT', {**entrada, 'precio': 15, 'version': producto['version']})
            r.comprobar(valido['version'] == producto['version'] + 1, 'Versión del servidor')
            r.pedir(sesion, ruta, 'PUT', {**entrada, 'precio': 99, 'version': producto['version']}, 409)
            _, conservado = r.pedir(sesion, ruta)
            r.comprobar(conservado == valido, 'El conflicto no cambia el dato')
            salida.append(r)
        # El primer proceso terminó antes de abrir el mismo archivo con el segundo.
        with aplicacion('laboratorios/jpa-productos', env, 'backend-archivo-reinicio', args, aislar=True) as base:
            r = Recorrido(base)
            r.caso('JPA: reiniciar conserva id, precio y versión')
            _, posterior = r.pedir(cliente(), ruta)
            r.comprobar(posterior == valido, 'El archivo conserva el recurso completo')
            _, pagina = r.pedir(cliente(), '/api/productos?nombre=Material%20durable')
            r.comprobar(pagina['total'] == 1, 'El reinicio no duplica el registro')
            salida.append(r)


def proveedor(h, salida):
    _raiz, Recorrido, aplicacion, base_env, cliente = h
    with proveedor_local() as (url, estado):
        env = base_env()
        env.update(SPRING_PROFILES_ACTIVE='dev', PROVEEDOR_URL=url)
        with aplicacion('ejemplos/api-productos', env, 'backend-proveedor', ('--app.intentos=2',), aislar=True) as base:
            r = Recorrido(base, csrf=True)
            editor = cliente('editor', env['APP_EDITOR_PASSWORD'])
            entrada = {'sku': 'BACK-PROV', 'nombre': 'Material cotizado', 'precio': 10, 'categoriaId': 1}
            _, producto = r.pedir(editor, '/api/productos', 'POST', entrada, 201)
            for modo, esperado, llamadas in [('valido', 200, 1), ('otro-sku', 503, 1),
                    ('json-roto', 503, 1), ('ausente', 404, 1), ('limite', 503, 1),
                    ('transitorio', 200, 2), ('caido', 503, 2)]:
                r.caso('Proveedor: ' + modo)
                estado.update(modo=modo, llamadas=0)
                _, datos = r.pedir(cliente(), '/api/cotizaciones/BACK-PROV', status=esperado)
                r.comprobar(estado['llamadas'] == llamadas, 'Cantidad acotada de llamadas externas')
                if esperado == 200:
                    r.comprobar(datos == {'sku': 'BACK-PROV', 'precio': 75}, 'Cotización válida')
                else:
                    codigo = 'NOT_FOUND' if esperado == 404 else 'PROVIDER_UNAVAILABLE'
                    r.comprobar(datos['code'] == codigo and 'trace' not in datos, 'Error del contrato local')
                _, posterior = r.pedir(cliente(), '/api/productos/' + str(producto['id']))
                r.comprobar(posterior == producto, 'Consultar proveedor no modifica catálogo ni versión')
            salida.append(r)


def seguridad(h, salida):
    _raiz, Recorrido, aplicacion, base_env, cliente = h
    env = base_env()
    env['SPRING_PROFILES_ACTIVE'] = 'dev'
    with aplicacion('ejemplos/api-productos', env, 'backend-seguridad', aislar=True) as base:
        r = Recorrido(base, csrf=True)
        anonimo, lector = cliente(), cliente('lector', env['APP_LECTOR_PASSWORD'])
        editor = cliente('editor', env['APP_EDITOR_PASSWORD'])
        entrada = {'sku': 'BACK-SEG', 'nombre': 'Material autorizado', 'precio': 10, 'categoriaId': 1}
        r.caso('Seguridad: identidad, autoridad y token se comprueban por separado')
        r.pedir(anonimo, '/api/productos', 'POST', entrada, 401)
        r.pedir(lector, '/api/productos', 'POST', entrada, 403)
        r.pedir(editor, '/api/productos', 'POST', entrada, 403, csrf=False)
        r.pedir(editor, '/api/productos', 'POST', entrada, 201)
        r.caso('Seguridad: un cuerpo inválido debe alcanzar MVC para probar validación')
        invalida = {**entrada, 'sku': 'BACK-INV', 'precio': 0}
        r.pedir(lector, '/api/productos', 'POST', invalida, 403)
        _, error = r.pedir(editor, '/api/productos', 'POST', invalida, 400)
        r.comprobar(error['code'] == 'VALIDATION_ERROR' and 'precio' in error['campos'], 'Validación demostrada')
        _, pagina = r.pedir(anonimo, '/api/productos?nombre=Material%20autorizado')
        r.comprobar(pagina['total'] == 1, 'Rechazos no añaden productos')
        r.caso('Operación: leer catálogo no concede acceso a todas las rutas GET')
        _, salud = r.pedir(anonimo, '/actuator/health')
        r.comprobar(salud['status'] == 'UP' and 'components' not in salud, 'Salud pública limitada')
        r.pedir(anonimo, '/actuator/metrics', status=401)
        r.pedir(lector, '/actuator/metrics', status=403)
        r.pedir(editor, '/actuator/metrics')
        r.pedir(lector, '/api/pedidos/999999999', status=403)
        r.pedir(editor, '/api/pedidos/999999999', status=404)
        salida.append(r)


CASOS = {'rest': rest, 'persistencia': persistencia, 'proveedor': proveedor, 'seguridad': seguridad}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--spring', required=True, type=Path, help='Raíz de una copia local de Curso-Spring-Boot')
    parser.add_argument('--caso', choices=[*CASOS, 'todos'], default='rest')
    args = parser.parse_args()
    helpers = cargar(args.spring)
    casos = list(CASOS) if args.caso == 'todos' else [args.caso]
    modulos = {'rest': 'laboratorios/rest-memoria', 'persistencia': 'laboratorios/jpa-productos',
               'proveedor': 'ejemplos/api-productos', 'seguridad': 'ejemplos/api-productos'}
    for caso in casos:
        modulo = modulos[caso]
        jar = 'api-productos' if modulo.startswith('ejemplos') else modulo.split('/')[-1]
        if not (helpers[0] / modulo / 'target' / (jar + '.jar')).is_file():
            parser.error(f'Construye primero: mvn -f {modulo}/pom.xml verify (desde Curso-Spring-Boot)')
    recorridos = []
    for caso in casos:
        print('\nExperimento: ' + caso, flush=True)
        CASOS[caso](helpers, recorridos)
    resultado = {'revision_spring': REVISION, 'experimentos': casos}
    for campo in ('casos', 'peticiones', 'comprobaciones'):
        resultado[campo] = sum(getattr(r, campo) for r in recorridos)
    print('\n' + json.dumps(resultado, ensure_ascii=False), flush=True)


if __name__ == '__main__':
    main()
