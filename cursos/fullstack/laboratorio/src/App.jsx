import React, { useEffect, useRef, useState } from 'react';
import { actualizarProducto, crearProducto, eliminarProducto, listarCategorias, listarProductos } from './api.js';

const vacio = { sku: '', nombre: '', precio: '', categoriaId: '' };
const moneda = new Intl.NumberFormat('es-CO', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

export default function App({ navigation = null }) {
  const [productos, setProductos] = useState([]);
  const [categorias, setCategorias] = useState([]);
  const [paginacion, setPaginacion] = useState({ total: 0, paginas: 0 });
  const [pagina, setPagina] = useState(0);
  const [busqueda, setBusqueda] = useState('');
  const [filtro, setFiltro] = useState('');
  const [revision, setRevision] = useState(0);
  const [cargando, setCargando] = useState(true);
  const [guardando, setGuardando] = useState(false);
  const [errorCarga, setErrorCarga] = useState('');
  const [errorOperacion, setErrorOperacion] = useState('');
  const [campos, setCampos] = useState({});
  const [mensaje, setMensaje] = useState('');
  const [form, setForm] = useState(vacio);
  const [editando, setEditando] = useState(null);
  const [pendienteEliminar, setPendienteEliminar] = useState(null);
  const skuRef = useRef(null);
  const eliminarRef = useRef(null);
  const cancelarEliminarRef = useRef(null);

  useEffect(() => {
    const controller = new AbortController();
    setCargando(true);
    setErrorCarga('');
    // Vaciar datos evita presentar como actuales registros de una carga fallida.
    setProductos([]);
    Promise.all([listarProductos({ nombre: filtro, pagina }, controller.signal), listarCategorias(controller.signal)])
      .then(([resultado, opciones]) => {
        if (controller.signal.aborted) return;
        // Tras borrar el último elemento de una página, retroceder si hace falta.
        if (pagina > 0 && resultado.contenido.length === 0) {
          setPagina(Math.max(0, resultado.paginas - 1));
          return;
        }
        setProductos(resultado.contenido);
        setPaginacion({ total: resultado.total, paginas: resultado.paginas });
        setCategorias(opciones);
      })
      .catch(error => { if (!controller.signal.aborted) setErrorCarga(error.message); })
      .finally(() => { if (!controller.signal.aborted) setCargando(false); });
    return () => controller.abort();
  }, [filtro, pagina, revision]);

  useEffect(() => {
    if (pendienteEliminar) cancelarEliminarRef.current?.focus();
  }, [pendienteEliminar]);

  const ocupado = guardando || cargando;
  function cambiar(event) {
    setForm(actual => ({ ...actual, [event.target.name]: event.target.value }));
  }
  function limpiar() {
    setEditando(null); setForm(vacio); setCampos({}); setErrorOperacion('');
  }
  function editar(producto) {
    setEditando({ id: producto.id, version: producto.version });
    setForm({ sku: producto.sku, nombre: producto.nombre, precio: String(producto.precio), categoriaId: String(producto.categoriaId) });
    setCampos({}); setErrorOperacion(''); setMensaje('');
    skuRef.current?.focus();
  }
  async function guardar(event) {
    event.preventDefault();
    if (ocupado || errorCarga) return;
    setGuardando(true); setErrorOperacion(''); setCampos({}); setMensaje('');
    const body = { sku: form.sku.trim(), nombre: form.nombre.trim(), precio: Number(form.precio), categoriaId: Number(form.categoriaId) };
    try {
      const producto = editando
        ? await actualizarProducto(editando.id, { ...body, version: editando.version })
        : await crearProducto(body);
      setMensaje(`Producto ${producto.nombre} ${editando ? 'actualizado' : 'creado'}.`);
      limpiar();
      setRevision(value => value + 1);
    } catch (error) {
      setCampos(error.campos || {});
      setErrorOperacion(error.status === 409
        ? 'Conflicto: el SKU ya existe o el producto cambió desde que lo abriste. Conservamos tu formulario. Actualiza el catálogo y vuelve a abrir el producto para comparar los datos.'
        : error.message);
    } finally { setGuardando(false); }
  }
  async function confirmarEliminar() {
    if (ocupado || !pendienteEliminar) return;
    setGuardando(true); setErrorOperacion(''); setMensaje('');
    try {
      await eliminarProducto(pendienteEliminar.id);
      setMensaje(`Producto ${pendienteEliminar.nombre} eliminado.`);
      if (editando?.id === pendienteEliminar.id) limpiar();
      setPendienteEliminar(null);
      setRevision(value => value + 1);
      skuRef.current?.focus();
    } catch (error) { setErrorOperacion(error.message); setPendienteEliminar(null); skuRef.current?.focus(); }
    finally { setGuardando(false); }
  }
  function cancelarEliminar() {
    setPendienteEliminar(null);
    eliminarRef.current?.focus();
  }
  function tecladoDialogo(event) {
    if (event.key === 'Escape' && !guardando) cancelarEliminar();
    if (event.key === 'Tab') {
      const botones = Array.from(event.currentTarget.querySelectorAll('button:not(:disabled)'));
      if (!botones.length) { event.preventDefault(); return; }
      const primero = botones[0], ultimo = botones[botones.length - 1];
      if (event.shiftKey && document.activeElement === primero) { event.preventDefault(); ultimo.focus(); }
      else if (!event.shiftKey && document.activeElement === ultimo) { event.preventDefault(); primero.focus(); }
    }
  }
  const controlesFondo = pendienteEliminar ? { inert: true } : {};
  return <>
    <div {...controlesFondo}>
      {navigation}
      <header className="cabecera"><div className="contenedor"><p className="marca">APRENDE CON LELI · LABORATORIO FULL STACK</p><h1>Catálogo de productos</h1><p>Consulta, crea y actualiza productos con una API y una base de datos.</p></div></header>
      <main className="contenedor">
        <aside className="nota">Práctica local con datos ficticios. Al reiniciar el perfil H2 de demostración, vuelven los datos iniciales.</aside>
        <p role="status" className="mensaje">{mensaje}</p>
        {errorOperacion && <div role="alert" className="error">{errorOperacion}</div>}
        <div className="columnas">
          <section className="tarjeta" aria-labelledby="form-title">
            <p className="paso">01 · GESTIONA</p><h2 id="form-title">{editando ? 'Editar producto' : 'Nuevo producto'}</h2>
            {editando && <p>Producto {editando.id} · versión {editando.version}</p>}
            <form onSubmit={guardar}>
              <fieldset disabled={ocupado || Boolean(errorCarga) || categorias.length === 0}>
                <label htmlFor="sku">SKU</label>
                <input ref={skuRef} id="sku" name="sku" value={form.sku} onChange={cambiar} required maxLength={32} pattern="[A-Z0-9-]{1,32}" aria-describedby="sku-hint sku-error" aria-invalid={Boolean(campos.sku)} />
                <small id="sku-hint">Código único: letras mayúsculas, números y guion.</small><small id="sku-error" className="campo-error">{campos.sku}</small>
                <label htmlFor="nombre">Nombre</label><input id="nombre" name="nombre" value={form.nombre} onChange={cambiar} required maxLength={100} aria-invalid={Boolean(campos.nombre)} aria-describedby="nombre-error" /><small id="nombre-error" className="campo-error">{campos.nombre}</small>
                <label htmlFor="precio">Precio</label><input id="precio" name="precio" type="number" min="0.01" max="9999999999.99" step="0.01" required value={form.precio} onChange={cambiar} aria-invalid={Boolean(campos.precio)} aria-describedby="precio-error" /><small id="precio-error" className="campo-error">{campos.precio}</small>
                <label htmlFor="categoriaId">Categoría</label><select id="categoriaId" name="categoriaId" value={form.categoriaId} onChange={cambiar} required aria-invalid={Boolean(campos.categoriaId)} aria-describedby="categoria-error"><option value="">Selecciona una categoría</option>{categorias.map(c => <option value={c.id} key={c.id}>{c.nombre}</option>)}</select><small id="categoria-error" className="campo-error">{campos.categoriaId}</small>
                <div className="acciones"><button type="submit">{guardando ? 'Guardando…' : editando ? 'Guardar cambios' : 'Crear producto'}</button>{editando && <button type="button" className="secundario" onClick={limpiar}>Cancelar edición</button>}</div>
              </fieldset>
            </form>
          </section>
          <section className="tarjeta" aria-labelledby="catalogo-title" aria-busy={cargando}>
            <p className="paso">02 · EXPLORA</p><h2 id="catalogo-title">Productos</h2>
            <form className="buscador" onSubmit={event => { event.preventDefault(); setPagina(0); setFiltro(busqueda.trim()); setRevision(value => value + 1); }}>
              <label htmlFor="buscar">Buscar por nombre</label><div className="acciones"><input id="buscar" maxLength={100} value={busqueda} onChange={event => setBusqueda(event.target.value)} disabled={guardando} /><button disabled={ocupado}>Buscar</button><button type="button" className="secundario" disabled={ocupado} onClick={() => setRevision(value => value + 1)}>Actualizar catálogo</button></div>
            </form>
            {cargando && <p role="status">Cargando catálogo…</p>}
            {errorCarga && <div role="alert" className="error"><p>{errorCarga}</p><button onClick={() => setRevision(value => value + 1)}>Reintentar</button></div>}
            {!cargando && !errorCarga && <>
              <p>{paginacion.total} productos encontrados.</p>
              {productos.length === 0 ? <p className="vacio">No hay productos para esta búsqueda.</p> : <div className="tabla-scroll"><table><caption className="solo-lectores">Productos de la página actual</caption><thead><tr><th scope="col">Producto</th><th scope="col">Categoría</th><th scope="col">Precio</th><th scope="col">Acciones</th></tr></thead><tbody>{productos.map(p => <tr key={p.id}><th scope="row"><strong>{p.nombre}</strong><small>{p.sku}</small></th><td>{p.categoria}</td><td>{moneda.format(p.precio)}</td><td><div className="acciones"><button className="secundario" disabled={ocupado} onClick={() => editar(p)} aria-label={`Editar ${p.nombre}`}>Editar</button><button className="peligro" disabled={ocupado} onClick={event => { eliminarRef.current = event.currentTarget; setPendienteEliminar(p); }} aria-label={`Eliminar ${p.nombre}`}>Eliminar</button></div></td></tr>)}</tbody></table></div>}
              <nav className="paginacion" aria-label="Páginas del catálogo"><button className="secundario" disabled={ocupado || pagina === 0} onClick={() => setPagina(value => value - 1)}>Anterior</button><span>Página {paginacion.paginas === 0 ? 0 : pagina + 1} de {paginacion.paginas}</span><button className="secundario" disabled={ocupado || pagina + 1 >= paginacion.paginas} onClick={() => setPagina(value => value + 1)}>Siguiente</button></nav>
            </>}
          </section>
        </div>
        <footer>React → HTTP y JSON → Spring Boot → JPA → Base de datos</footer>
      </main>
    </div>
    {pendienteEliminar && <div className="modal-fondo"><section className="modal" role="dialog" aria-modal="true" aria-labelledby="delete-title" aria-describedby="delete-detail" onKeyDown={tecladoDialogo}><h2 id="delete-title">¿Eliminar producto?</h2><p id="delete-detail">Vas a eliminar {pendienteEliminar.nombre}. Esta operación no se puede deshacer desde el catálogo.</p><div className="acciones"><button ref={cancelarEliminarRef} className="secundario" disabled={guardando} onClick={cancelarEliminar}>Cancelar</button><button className="peligro" disabled={guardando} onClick={confirmarEliminar}>{guardando ? 'Eliminando…' : 'Confirmar eliminación'}</button></div></section></div>}
  </>;
}
