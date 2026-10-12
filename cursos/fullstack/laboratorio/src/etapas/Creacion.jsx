import React, { useEffect, useState } from 'react';
import { crearProducto, listarCategorias } from '../api.js';
import Consulta from './Consulta.jsx';

const inicial = { sku: '', nombre: '', precio: '', categoriaId: '' };
export default function Creacion() {
  const [form, setForm] = useState(inicial);
  const [categorias, setCategorias] = useState([]);
  const [cargando, setCargando] = useState(true);
  const [errorCategorias, setErrorCategorias] = useState('');
  const [intento, setIntento] = useState(0);
  const [guardando, setGuardando] = useState(false);
  const [error, setError] = useState('');
  const [mensaje, setMensaje] = useState('');
  const [revision, setRevision] = useState(0);

  useEffect(() => {
    const controller = new AbortController();
    setCargando(true); setErrorCategorias(''); setCategorias([]);
    listarCategorias(controller.signal)
      .then(datos => { if (!controller.signal.aborted) setCategorias(datos); })
      .catch(fallo => { if (!controller.signal.aborted) setErrorCategorias(fallo.message); })
      .finally(() => { if (!controller.signal.aborted) setCargando(false); });
    return () => controller.abort();
  }, [intento]);

  function cambiar(event) {
    setForm(actual => ({ ...actual, [event.target.name]: event.target.value }));
  }
  async function guardar(event) {
    event.preventDefault();
    if (guardando || cargando || errorCategorias || categorias.length === 0) return;
    setGuardando(true); setError(''); setMensaje('');
    const datos = {
      sku: form.sku.trim(), nombre: form.nombre.trim(),
      precio: Number(form.precio), categoriaId: Number(form.categoriaId)
    };
    try {
      const producto = await crearProducto(datos);
      setMensaje(`Producto ${producto.nombre} creado.`);
      setForm(inicial);
      setRevision(valor => valor + 1);
    } catch (fallo) {
      setError(fallo.status === 409 ? 'Ya existe ese SKU. Cambia el código y vuelve a intentar.' : fallo.message);
      // El formulario se conserva: el usuario puede corregir su propuesta.
    } finally { setGuardando(false); }
  }

  return <div className="columnas">
    <section className="tarjeta" aria-labelledby="crear-title">
      <h2 id="crear-title">Crear un producto</h2>
      <p role="status" className="mensaje">{mensaje}</p>
      {cargando && <p role="status">Consultando categorías…</p>}
      {errorCategorias && <div role="alert" className="error"><p>{errorCategorias}</p><button onClick={() => setIntento(valor => valor + 1)}>Reintentar categorías</button></div>}
      {!cargando && !errorCategorias && categorias.length === 0 && <p>No hay categorías. Usa el perfil de demostración del laboratorio JPA.</p>}
      {error && <p role="alert" className="error">{error}</p>}
      <form onSubmit={guardar}>
        <fieldset disabled={guardando || cargando || Boolean(errorCategorias) || categorias.length === 0}>
          <label htmlFor="nuevo-sku">SKU</label><input id="nuevo-sku" name="sku" value={form.sku} onChange={cambiar} required maxLength={32} pattern="[A-Z0-9-]{1,32}" aria-describedby="codigo-ayuda" />
          <small id="codigo-ayuda">Mayúsculas, números y guion; código único.</small>
          <label htmlFor="nuevo-nombre">Nombre</label><input id="nuevo-nombre" name="nombre" value={form.nombre} onChange={cambiar} required maxLength={100} />
          <label htmlFor="nuevo-precio">Precio</label><input id="nuevo-precio" name="precio" type="number" required min="0.01" max="9999999999.99" step="0.01" value={form.precio} onChange={cambiar} />
          <label htmlFor="nueva-categoria">Categoría</label><select id="nueva-categoria" name="categoriaId" required value={form.categoriaId} onChange={cambiar}><option value="">Selecciona una categoría</option>{categorias.map(c => <option key={c.id} value={c.id}>{c.nombre}</option>)}</select>
          <div className="acciones"><button>{guardando ? 'Creando…' : 'Crear producto'}</button></div>
        </fieldset>
      </form>
    </section>
    <Consulta revision={revision} />
  </div>;
}
