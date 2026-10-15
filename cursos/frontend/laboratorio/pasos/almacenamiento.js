import { cargar, guardar } from '../src/almacenamiento.js';

// Misma regla de documento; clave separada para la construcción guiada.
export const CLAVE_PASOS = 'leli.frontend.construccion.v1';
const aislado = {
  getItem() { return globalThis.localStorage.getItem(CLAVE_PASOS); },
  setItem(_clave, valor) { globalThis.localStorage.setItem(CLAVE_PASOS, valor); }
};
export function leerPlan() { return cargar(aislado); }
export function guardarPlan(tareas) { return guardar(tareas, aislado); }
