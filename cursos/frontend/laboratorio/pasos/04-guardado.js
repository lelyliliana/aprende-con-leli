import { agregar, alternar, eliminar, filtrar } from '../src/dominio.js';
import { leerPlan, guardarPlan } from './almacenamiento.js';

export function iniciarGuardado(raiz = document) {
  const inicio = leerPlan();
  let tareas = inicio.tareas;
  const form = raiz.querySelector('form');
  const campo = raiz.querySelector('#titulo');
  const lista = raiz.querySelector('#lista');
  const filtro = raiz.querySelector('#filtro');
  const error = raiz.querySelector('#error');
  const mensaje = raiz.querySelector('#mensaje');
  const resumen = raiz.querySelector('#resumen');

  function representar() {
    lista.replaceChildren();
    resumen.textContent = `${tareas.filter(t => !t.completa).length} pendientes de ${tareas.length}.`;
    const visibles = filtrar(tareas, filtro.value);
    if (visibles.length === 0) {
      const vacio = document.createElement('li');
      vacio.textContent = 'No hay tareas para este filtro.';
      lista.append(vacio);
    }
    for (const tarea of visibles) {
      const fila = document.createElement('li');
      const etiqueta = document.createElement('label');
      const casilla = document.createElement('input');
      const texto = document.createElement('span');
      const boton = document.createElement('button');
      casilla.type = 'checkbox';
      casilla.checked = tarea.completa;
      casilla.disabled = Boolean(inicio.error);
      casilla.addEventListener('change', () => aplicar(ts => alternar(ts, tarea.id), 'Estado actualizado.'));
      texto.textContent = tarea.titulo;
      boton.type = 'button';
      boton.disabled = Boolean(inicio.error);
      boton.textContent = 'Eliminar';
      boton.className = 'secundario';
      boton.setAttribute('aria-label', `Eliminar ${tarea.titulo}`);
      boton.addEventListener('click', () => aplicar(ts => eliminar(ts, tarea.id), 'Tarea eliminada.'));
      etiqueta.append(casilla, texto);
      fila.append(etiqueta, boton);
      lista.append(fila);
    }
  }

  function aplicar(cambio, texto) {
    if (inicio.error) return false;
    try {
      tareas = cambio(tareas);
      error.textContent = guardarPlan(tareas);
      mensaje.textContent = texto;
      representar();
      campo.focus();
      return true;
    } catch (fallo) {
      error.textContent = fallo.message;
      return false;
    }
  }

  error.textContent = inicio.error;
  campo.disabled = Boolean(inicio.error);
  form.querySelector('button').disabled = Boolean(inicio.error);
  form.addEventListener('submit', evento => {
    evento.preventDefault();
    if (aplicar(ts => agregar(ts, campo.value), 'Tarea agregada.')) campo.value = '';
  });
  filtro.addEventListener('change', representar);
  representar();
}

if (document.querySelector('[data-plan="guardado"]')) iniciarGuardado();
