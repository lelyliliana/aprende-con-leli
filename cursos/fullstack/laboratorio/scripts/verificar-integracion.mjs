import assert from 'node:assert/strict';

// Hace peticiones a Vite, no directamente a Spring: prueba el proxy real.
const origen = process.env.LAB_ORIGIN || 'http://127.0.0.1:5173';
const sku = `FS-${Date.now()}`;
let creado;
async function pedir(ruta, { method = 'GET', body } = {}) {
  const response = await fetch(`${origen}/api${ruta}`, {
    method, signal: AbortSignal.timeout(10000),
    headers: { Accept: 'application/json', ...(body ? { 'Content-Type': 'application/json' } : {}) },
    ...(body ? { body: JSON.stringify(body) } : {})
  });
  const text = await response.text();
  let data;
  try { data = text ? JSON.parse(text) : null; } catch { throw new Error(`Respuesta inesperada (${response.status}). Comprueba Vite y Spring Boot.`); }
  return { status: response.status, data, location: response.headers.get('location') };
}
try {
  const categorias = await pedir('/categorias'); assert.equal(categorias.status, 200);
  assert.ok(categorias.data.length > 0, 'Usa el perfil dev con categorías de demostración');
  const body = { sku, nombre: 'Producto de prueba Full Stack', precio: 25.5, categoriaId: categorias.data[0].id };
  const creadoResponse = await pedir('/productos', { method: 'POST', body });
  assert.equal(creadoResponse.status, 201); creado = creadoResponse.data.id;
  assert.ok(creadoResponse.location?.endsWith(`/productos/${creado}`));
  const original = creadoResponse.data;
  let r = await pedir(`/productos/${creado}`); assert.equal(r.status, 200); assert.equal(r.data.sku, sku);
  r = await pedir('/productos?nombre=Producto%20de%20prueba%20Full%20Stack&pagina=0&tamano=5');
  assert.equal(r.status, 200); assert.ok(r.data.contenido.some(p => p.id === creado));
  r = await pedir('/productos', { method: 'POST', body }); assert.equal(r.status, 409);
  r = await pedir('/productos', { method: 'POST', body: { ...body, sku: `${sku}-B`, precio: 0 } });
  assert.equal(r.status, 400); assert.ok(r.data.campos.precio);
  r = await pedir(`/productos/${creado}`, { method: 'PUT', body: { ...body, nombre: 'Producto actualizado', version: original.version } });
  assert.equal(r.status, 200); assert.ok(r.data.version > original.version);
  r = await pedir(`/productos/${creado}`, { method: 'PUT', body: { ...body, nombre: 'No debe guardarse', version: original.version } });
  assert.equal(r.status, 409);
  r = await pedir(`/productos/${creado}`); assert.equal(r.data.nombre, 'Producto actualizado');
  r = await pedir('/productos?nombre=FS-SIN-COINCIDENCIAS-XYZ&pagina=0&tamano=5');
  assert.equal(r.status, 200); assert.equal(r.data.contenido.length, 0);
  r = await pedir(`/productos/${creado}`, { method: 'DELETE' }); assert.equal(r.status, 204); assert.equal(r.data, null);
  r = await pedir(`/productos/${creado}`); assert.equal(r.status, 404);
  creado = null;
  console.log('Integración correcta: proxy, categorías, CRUD, filtro, validación, duplicado, conflicto de versión, 204 y 404.');
} finally {
  if (creado) {
    try { await pedir(`/productos/${creado}`, { method: 'DELETE' }); }
    catch { console.error(`No se pudo limpiar el producto de prueba ${creado}.`); }
  }
}
