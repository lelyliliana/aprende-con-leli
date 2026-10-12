import React, { useEffect, useState } from 'react';
import { listarProductos } from '../api.js';

// Primera etapa: seguir una consulta antes de estudiar las escrituras.
export default function Consulta({ revision = 0 }) {
  const [productos, setProductos] = useState([]);
  const [total, setTotal] = useState(0);
  const [cargando, setCargando] = useState(true);
  const [error, setError] = useState('');
  const [intento, setIntento] = useState(0);

  useEffect(() => {
    const controller = new AbortController();
    setCargando(true);
    setError('');
    setProductos([]);
    listarProductos({}, controller.signal)
      .then(pagina => {
        if (controller.signal.aborted) return;
        setProductos(pagina.contenido);
        setTotal(pagina.total);
      })
      .catch(fallo => {
        if (!controller.signal.aborted) setError(fallo.message);
      })
      .finally(() => {
        if (!controller.signal.aborted) setCargando(false);
      });
    return () => controller.abort();
  }, [revision, intento]);

  return <section className="tarjeta" aria-labelledby="consulta-title" aria-busy={cargando}>
    <h2 id="consulta-title">Consulta del catálogo</h2>
    {cargando && <p role="status">Consultando productos…</p>}
    {error && <div role="alert" className="error"><p>{error}</p><button onClick={() => setIntento(valor => valor + 1)}>Reintentar consulta</button></div>}
    {!cargando && !error && <>
      <p>{total} productos en total. Esta etapa muestra la primera página (hasta cinco registros).</p>
      {productos.length === 0 ? <p>No hay productos.</p> : <ul>{productos.map(producto => <li key={producto.id}><strong>{producto.nombre}</strong> · {producto.categoria} · {Number(producto.precio).toFixed(2)}</li>)}</ul>}
      <button className="secundario" onClick={() => setIntento(valor => valor + 1)}>Volver a consultar</button>
    </>}
  </section>;
}
