import { agregar, alternar, eliminar, filtrar } from '../src/dominio.js';

export function iniciarMemoria(raiz = document) {
  let tareas = [];
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
      casilla.addEventListener('change', () => aplicar(ts => alternar(ts, tarea.id), 'Estado actualizado.'));
      texto.textContent = tarea.titulo;
      boton.type = 'button';
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
    try {
      tareas = cambio(tareas);
      error.textContent = '';
      mensaje.textContent = texto;
      representar();
      campo.focus();
      return true;
    } catch (fallo) {
      error.textContent = fallo.message;
      return false;
    }
  }

  form.addEventListener('submit', evento => {
    evento.preventDefault();
    if (aplicar(ts => agregar(ts, campo.value), 'Tarea agregada.')) campo.value = '';
  });
  filtro.addEventListener('change', representar);
  representar();
}

if (document.querySelector('[data-plan="memoria"]')) iniciarMemoria();
