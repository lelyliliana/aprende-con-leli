import React from 'react';
import { readFileSync } from 'node:fs';
import { beforeEach, expect, it, vi } from 'vitest';
import { cleanup, render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { Plan } from './05-react.jsx';
import { CLAVE_PASOS, leerPlan } from './almacenamiento.js';
import { CLAVE } from '../src/almacenamiento.js';

async function abrirDom(nombre) {
  cleanup();
  const html = readFileSync(`pasos/${nombre}.html`, 'utf8');
  document.body.innerHTML = html.match(/<body>([\s\S]*)<\/body>/)[1];
  vi.resetModules();
  if (nombre === '03-memoria') await import('./03-memoria.js');
  else await import('./04-guardado.js');
}

beforeEach(() => {
  vi.restoreAllMocks();
  cleanup();
  document.body.replaceChildren();
});

it('la etapa en memoria conserva texto literal, filtra sin borrar y no persiste', async () => {
  const user = userEvent.setup();
  await abrirDom('03-memoria');
  const guardar = vi.spyOn(Storage.prototype, 'setItem');
  await user.type(screen.getByLabelText('Título de la tarea'), '<img src=x>');
  await user.click(screen.getByRole('button', { name: 'Agregar tarea' }));
  expect(document.querySelector('#lista img')).toBeNull();
  await user.click(screen.getByRole('checkbox'));
  await user.selectOptions(screen.getByLabelText('Mostrar'), 'pendientes');
  expect(screen.getByText('No hay tareas para este filtro.')).toBeTruthy();
  await user.selectOptions(screen.getByLabelText('Mostrar'), 'todas');
  expect(screen.getByText('<img src=x>')).toBeTruthy();
  expect(guardar).not.toHaveBeenCalled();
  await abrirDom('03-memoria');
  expect(screen.queryByRole('checkbox')).toBeNull();
});

it('guardado y React transfieren la misma identidad sin modificar el plan completo', async () => {
  const original = JSON.stringify({ version: 1, tareas: [{ id: 'principal', titulo: 'Plan completo', completa: false }] });
  localStorage.setItem(CLAVE, original);
  const user = userEvent.setup();
  await abrirDom('04-guardado');
  await user.type(screen.getByLabelText('Título de la tarea'), '  CSS  ');
  await user.click(screen.getByRole('button', { name: 'Agregar tarea' }));
  const [primera] = leerPlan().tareas;
  expect(primera.titulo).toBe('CSS');
  document.body.replaceChildren();
  render(<Plan />);
  expect(screen.getByText('CSS')).toBeTruthy();
  await user.click(screen.getByRole('checkbox'));
  expect(leerPlan().tareas[0]).toEqual({ ...primera, completa: true });
  await abrirDom('04-guardado');
  expect(screen.getByRole('checkbox').checked).toBe(true);
  expect(localStorage.getItem(CLAVE)).toBe(original);
});

it('ambas interfaces bloquean un documento inválido sin reemplazarlo', async () => {
  localStorage.setItem(CLAVE_PASOS, 'documento roto');
  await abrirDom('04-guardado');
  expect(screen.getByRole('button', { name: 'Agregar tarea' }).disabled).toBe(true);
  expect(screen.getByRole('alert').textContent).toContain('Conservamos');
  document.body.replaceChildren();
  render(<Plan />);
  expect(screen.getByRole('button', { name: 'Agregar tarea' }).disabled).toBe(true);
  expect(localStorage.getItem(CLAVE_PASOS)).toBe('documento roto');
});

it('la etapa guardada conserva el cambio en sesión e informa fallo de escritura', async () => {
  const user = userEvent.setup();
  await abrirDom('04-guardado');
  vi.spyOn(Storage.prototype, 'setItem').mockImplementation(() => { throw new Error('Cuota'); });
  await user.type(screen.getByLabelText('Título de la tarea'), 'JavaScript');
  await user.click(screen.getByRole('button', { name: 'Agregar tarea' }));
  expect(screen.getByText('JavaScript')).toBeTruthy();
  expect(screen.getByRole('alert').textContent).toContain('esta sesión');
  expect(localStorage.getItem(CLAVE_PASOS)).toBeNull();
});

it('el adaptador también captura un bloqueo del acceso a localStorage', () => {
  const descriptor = Object.getOwnPropertyDescriptor(globalThis, 'localStorage');
  Object.defineProperty(globalThis, 'localStorage', { configurable: true, get() { throw new Error('Bloqueado'); } });
  try {
    render(<Plan />);
    expect(screen.getByRole('alert').textContent).toContain('Conservamos');
    expect(screen.getByRole('button', { name: 'Agregar tarea' }).disabled).toBe(true);
  } finally {
    Object.defineProperty(globalThis, 'localStorage', descriptor);
  }
});
