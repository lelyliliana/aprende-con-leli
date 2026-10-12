const base = (import.meta.env.VITE_API_URL || '').replace(/\/$/, '');

export class ApiError extends Error {
  constructor(message, status = 0, campos = {}) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
    this.campos = campos;
  }
}

export async function request(path, { method = 'GET', body, signal } = {}) {
  // Las escrituras no se reintentan automáticamente: podría haberse aplicado
  // la operación aunque se pierda su respuesta.
  const timeout = AbortSignal.timeout(8000);
  const combined = signal ? AbortSignal.any([signal, timeout]) : timeout;
  let response;
  try {
    response = await fetch(`${base}/api${path}`, {
      method,
      headers: { Accept: 'application/json, application/problem+json',
        ...(body === undefined ? {} : { 'Content-Type': 'application/json' }) },
      ...(body === undefined ? {} : { body: JSON.stringify(body) }),
      signal: combined
    });
  } catch (error) {
    if (signal?.aborted) throw error;
    const message = timeout.aborted
      ? 'La API tardó demasiado. Comprueba su estado antes de repetir la operación.'
      : 'No pudimos conectar con la API. Comprueba que Spring Boot esté iniciado.';
    throw new ApiError(message);
  }
  if (response.status === 204) return null;
  // Una respuesta del proxy puede ser texto o estar vacía cuando la API cae.
  const type = response.headers.get('content-type') || '';
  const data = type.includes('json') ? await response.json() : null;
  if (!response.ok) {
    const fallback = response.status >= 500 ? 'La API no está disponible. Comprueba el servidor y reintenta.' : `La petición falló (${response.status}).`;
    throw new ApiError(data?.detail || fallback, response.status, data?.campos || {});
  }
  if (data === null) throw new ApiError('La API devolvió una respuesta inesperada.', response.status);
  return data;
}

export function listarProductos({ nombre = '', pagina = 0, tamano = 5 } = {}, signal) {
  const params = new URLSearchParams({ nombre, pagina: String(pagina), tamano: String(tamano) });
  return request(`/productos?${params}`, { signal });
}
export const listarCategorias = signal => request('/categorias', { signal });
export const crearProducto = body => request('/productos', { method: 'POST', body });
export const actualizarProducto = (id, body) => request(`/productos/${id}`, { method: 'PUT', body });
export const eliminarProducto = id => request(`/productos/${id}`, { method: 'DELETE' });
