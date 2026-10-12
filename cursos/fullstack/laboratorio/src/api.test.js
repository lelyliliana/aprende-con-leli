import { afterEach, describe, expect, it, vi } from 'vitest';
import { ApiError, actualizarProducto, eliminarProducto, listarProductos, request } from './api.js';

afterEach(() => vi.unstubAllGlobals());
describe('Contrato HTTP del cliente', () => {
  it('envía filtro y paginación sin concatenar texto del usuario', async () => {
    const fetchMock = vi.fn().mockResolvedValue(new Response('{"contenido":[]}', { headers: { 'content-type': 'application/json' } }));
    vi.stubGlobal('fetch', fetchMock);
    await listarProductos({ nombre: 'A & B', pagina: 2, tamano: 5 });
    const url = new URL(fetchMock.mock.calls[0][0], 'http://localhost');
    expect(url.searchParams.get('nombre')).toBe('A & B');
    expect(url.searchParams.get('pagina')).toBe('2');
  });
  it('conserva la versión en PUT', async () => {
    const mock = vi.fn().mockResolvedValue(new Response('{"version":4}', { headers: { 'content-type': 'application/json' } }));
    vi.stubGlobal('fetch', mock);
    await actualizarProducto(7, { sku: 'A', version: 3 });
    expect(mock.mock.calls[0][0]).toBe('/api/productos/7');
    expect(JSON.parse(mock.mock.calls[0][1].body).version).toBe(3);
  });
  it('acepta DELETE 204 sin intentar leer JSON', async () => {
    vi.stubGlobal('fetch', vi.fn().mockResolvedValue(new Response(null, { status: 204 })));
    expect(await eliminarProducto(7)).toBeNull();
  });
  it('propaga ProblemDetail y los errores de campos', async () => {
    vi.stubGlobal('fetch', vi.fn().mockResolvedValue(new Response(JSON.stringify({ detail: 'Revisa los campos', campos: { precio: 'Debe ser positivo' } }), { status: 400, headers: { 'content-type': 'application/problem+json' } })));
    await expect(request('/productos')).rejects.toMatchObject({ status: 400, campos: { precio: 'Debe ser positivo' } });
  });
  it('explica los errores del proxy incluso sin JSON', async () => {
    vi.stubGlobal('fetch', vi.fn().mockResolvedValue(new Response('Bad Gateway', { status: 502 })));
    await expect(request('/productos')).rejects.toMatchObject({ status: 502, message: expect.stringContaining('no está disponible') });
  });
  it('informa de una caída de red y no reintenta escrituras', async () => {
    const mock = vi.fn().mockRejectedValue(new TypeError('fetch failed'));
    vi.stubGlobal('fetch', mock);
    await expect(request('/productos', { method: 'POST', body: {} })).rejects.toBeInstanceOf(ApiError);
    expect(mock).toHaveBeenCalledTimes(1);
  });
});
