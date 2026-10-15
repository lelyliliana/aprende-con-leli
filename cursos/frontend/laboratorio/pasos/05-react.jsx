import React, { useRef, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { agregar, alternar, eliminar, filtrar } from '../src/dominio.js';
import { leerPlan, guardarPlan } from './almacenamiento.js';

export function Tarea({ tarea, bloqueada, alCompletar, alEliminar }) {
  return <li>
    <label>
      <input type="checkbox" checked={tarea.completa} disabled={bloqueada} onChange={() => alCompletar(tarea.id)} />
      <span>{tarea.titulo}</span>
    </label>
    <button type="button" className="secundario" disabled={bloqueada} onClick={() => alEliminar(tarea.id)} aria-label={`Eliminar ${tarea.titulo}`}>Eliminar</button>
  </li>;
}

export function Plan() {
  const [inicio] = useState(() => leerPlan());
  const [tareas, setTareas] = useState(inicio.tareas);
  const [titulo, setTitulo] = useState('');
  const [filtro, setFiltro] = useState('todas');
  const [error, setError] = useState(inicio.error);
  const [mensaje, setMensaje] = useState('');
  const campo = useRef(null);
  const visibles = filtrar(tareas, filtro);
  const pendientes = tareas.filter(t => !t.completa).length;

  function aplicar(cambio, texto) {
    if (inicio.error) return false;
    try {
      const nuevas = cambio(tareas);
      setTareas(nuevas);
      setError(guardarPlan(nuevas));
      setMensaje(texto);
      campo.current?.focus();
      return true;
    } catch (fallo) {
      setError(fallo.message);
      return false;
    }
  }

  function enviar(evento) {
    evento.preventDefault();
    if (aplicar(ts => agregar(ts, titulo), 'Tarea agregada.')) setTitulo('');
  }

  return <section className="tarjeta" aria-labelledby="plan-title">
    <h2 id="plan-title">Organiza tus tareas</h2>
    <p>React conserva el mismo documento del paso 4. La aplicación completa usa otra clave de práctica.</p>
    {error && <p className="error" role="alert">{error}</p>}
    <form onSubmit={enviar}>
      <label htmlFor="titulo">Título de la tarea</label>
      <p id="ayuda">De 1 a 80 unidades de longitud de texto. Hasta 100 tareas.</p>
      <div className="acciones">
        <input ref={campo} id="titulo" aria-describedby="ayuda" value={titulo} onChange={e => setTitulo(e.target.value)} required maxLength={80} disabled={Boolean(inicio.error)} />
        <button disabled={Boolean(inicio.error)}>Agregar tarea</button>
      </div>
    </form>
    <p role="status">{mensaje}</p>
    <p>{pendientes} pendientes de {tareas.length}.</p>
    <label htmlFor="filtro">Mostrar</label>
    <select id="filtro" value={filtro} onChange={e => setFiltro(e.target.value)}>
      <option value="todas">Todas</option><option value="pendientes">Pendientes</option><option value="completas">Completas</option>
    </select>
    {visibles.length === 0 ? <p>No hay tareas para este filtro.</p> : <ul>{visibles.map(tarea =>
      <Tarea key={tarea.id} tarea={tarea} bloqueada={Boolean(inicio.error)}
        alCompletar={id => aplicar(ts => alternar(ts, id), 'Estado actualizado.')}
        alEliminar={id => aplicar(ts => eliminar(ts, id), 'Tarea eliminada.')} />
    )}</ul>}
  </section>;
}

const contenedor = document.getElementById('paso-react');
if (contenedor) createRoot(contenedor).render(<React.StrictMode><Plan /></React.StrictMode>);
