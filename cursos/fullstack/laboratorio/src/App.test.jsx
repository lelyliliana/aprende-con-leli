import React from 'react';
import { beforeEach, expect, it, vi } from 'vitest';
import { render, screen, waitFor, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import App from './App.jsx';
import * as api from './api.js';
vi.mock('./api.js', () => ({ listarProductos: vi.fn(), listarCategorias: vi.fn(), crearProducto: vi.fn(), actualizarProducto: vi.fn(), eliminarProducto: vi.fn() }));
const producto = { id: 1, sku: 'LIB-01', nombre: 'Algoritmos', precio: 80, categoriaId: 1, categoria: 'Libros', version: 3 };
const resultado = (contenido = [producto], total = contenido.length, paginas = contenido.length ? 1 : 0) => ({ contenido, total, paginas });
beforeEach(() => {
  vi.resetAllMocks();
  api.listarProductos.mockResolvedValue(resultado());
  api.listarCategorias.mockResolvedValue([{ id: 1, nombre: 'Libros' }]);
});
async function abrir() {
  const user = userEvent.setup();
  render(<App />);
  await screen.findByRole('button', { name: 'Editar Algoritmos' });
  return user;
}
async function rellenar(user) {
  await user.type(screen.getByLabelText('SKU'), 'NUEVO-1');
  await user.type(screen.getByLabelText('Nombre'), 'Libro nuevo');
  await user.type(screen.getByLabelText('Precio'), '25.50');
  await user.selectOptions(screen.getByLabelText('Categoría'), '1');
}
it('crea con tipos numéricos, confirma y vuelve a consultar', async () => {
  api.crearProducto.mockResolvedValue({ nombre: 'Libro nuevo' });
  const user = await abrir();
  await rellenar(user);
  await user.click(screen.getByRole('button', { name: 'Crear producto' }));
  await waitFor(() => expect(api.crearProducto).toHaveBeenCalledWith({ sku: 'NUEVO-1', nombre: 'Libro nuevo', precio: 25.5, categoriaId: 1 }));
  await screen.findByText('Producto Libro nuevo creado.');
  expect(screen.getByLabelText('Nombre').value).toBe('');
  expect(api.listarProductos.mock.calls.length).toBeGreaterThan(1);
});
it('edita usando la versión recibida del backend', async () => {
  api.actualizarProducto.mockResolvedValue({ nombre: 'Algoritmos revisado', version: 4 });
  const user = await abrir();
  await user.click(screen.getByRole('button', { name: 'Editar Algoritmos' }));
  await user.clear(screen.getByLabelText('Nombre'));
  await user.type(screen.getByLabelText('Nombre'), 'Algoritmos revisado');
  await user.click(screen.getByRole('button', { name: 'Guardar cambios' }));
  await waitFor(() => expect(api.actualizarProducto).toHaveBeenCalledWith(1, { sku: 'LIB-01', nombre: 'Algoritmos revisado', precio: 80, categoriaId: 1, version: 3 }));
});
it('conserva el formulario y explica un conflicto 409', async () => {
  api.actualizarProducto.mockRejectedValue({ status: 409 });
  const user = await abrir();
  await user.click(screen.getByRole('button', { name: 'Editar Algoritmos' }));
  await user.type(screen.getByLabelText('Nombre'), ' modificado');
  await user.click(screen.getByRole('button', { name: 'Guardar cambios' }));
  expect((await screen.findByRole('alert')).textContent).toContain('Conflicto');
  expect(screen.getByLabelText('Nombre').value).toBe('Algoritmos modificado');
  expect(api.actualizarProducto).toHaveBeenCalledTimes(1);
});
it('muestra validación del servidor junto al campo sin borrar lo escrito', async () => {
  api.crearProducto.mockRejectedValue({ message: 'Revisa los campos', campos: { nombre: 'Nombre inválido' } });
  const user = await abrir(); await rellenar(user);
  await user.click(screen.getByRole('button', { name: 'Crear producto' }));
  await screen.findByText('Nombre inválido');
  expect(screen.getByLabelText('Nombre').getAttribute('aria-invalid')).toBe('true');
  expect(screen.getByLabelText('Nombre').value).toBe('Libro nuevo');
});
it('confirma eliminación y evita borrar al cancelar', async () => {
  api.eliminarProducto.mockResolvedValue(null);
  const user = await abrir();
  await user.click(screen.getByRole('button', { name: 'Eliminar Algoritmos' }));
  let dialogo = screen.getByRole('dialog');
  await user.click(within(dialogo).getByRole('button', { name: 'Cancelar' }));
  expect(api.eliminarProducto).not.toHaveBeenCalled();
  await user.click(screen.getByRole('button', { name: 'Eliminar Algoritmos' }));
  dialogo = screen.getByRole('dialog');
  await user.click(within(dialogo).getByRole('button', { name: 'Confirmar eliminación' }));
  await screen.findByText('Producto Algoritmos eliminado.');
  expect(api.eliminarProducto).toHaveBeenCalledWith(1);
});
it('permite recuperarse de una caída al reintentar', async () => {
  api.listarProductos.mockRejectedValueOnce(new Error('Servidor detenido'));
  const user = userEvent.setup(); render(<App />);
  await screen.findByText('Servidor detenido');
  await user.click(screen.getByRole('button', { name: 'Reintentar' }));
  await screen.findByRole('button', { name: 'Editar Algoritmos' });
  expect(screen.queryByRole('alert')).toBeNull();
});
it('distingue una búsqueda vacía y reinicia la página del filtro', async () => {
  const user = await abrir();
  api.listarProductos.mockResolvedValue(resultado([]));
  await user.type(screen.getByLabelText('Buscar por nombre'), 'inexistente');
  await user.click(screen.getByRole('button', { name: 'Buscar', exact: true }));
  await screen.findByText('No hay productos para esta búsqueda.');
  expect(api.listarProductos.mock.lastCall[0]).toEqual({ nombre: 'inexistente', pagina: 0 });
});
it('cancela una carga anterior al cambiar de consulta', async () => {
  const user = await abrir();
  const anterior = api.listarProductos.mock.calls[0][1];
  await user.click(screen.getByRole('button', { name: 'Actualizar catálogo' }));
  await waitFor(() => expect(anterior.aborted).toBe(true));
});
it('impide un segundo envío mientras está guardando', async () => {
  let resolver; api.crearProducto.mockReturnValue(new Promise(resolve => { resolver = resolve; }));
  const user = await abrir(); await rellenar(user);
  await user.click(screen.getByRole('button', { name: 'Crear producto' }));
  const boton = screen.getByRole('button', { name: 'Guardando…' });
  expect(boton.closest('fieldset').disabled).toBe(true);
  await user.click(boton);
  expect(api.crearProducto).toHaveBeenCalledTimes(1);
  resolver({ nombre: 'Libro nuevo' });
  await screen.findByText('Producto Libro nuevo creado.');
});
it('retrocede si se elimina el último producto de la última página', async () => {
  const paginas = { ...resultado([producto], 6, 2), pagina: 0 };
  api.listarProductos.mockImplementation(({ pagina }) => Promise.resolve(pagina === 1 ? { ...resultado([{ ...producto, id: 2, nombre: 'Último' }], 6, 2), pagina: 1 } : paginas));
  api.eliminarProducto.mockImplementation(async () => {
    api.listarProductos.mockImplementation(({ pagina }) => Promise.resolve(pagina === 1 ? { ...resultado([], 5, 1), pagina: 1 } : { ...resultado([producto], 5, 1), pagina: 0 }));
    return null;
  });
  const user = await abrir();
  await user.click(screen.getByRole('button', { name: 'Siguiente' }));
  await screen.findByRole('button', { name: 'Eliminar Último' });
  await user.click(screen.getByRole('button', { name: 'Eliminar Último' }));
  await user.click(within(screen.getByRole('dialog')).getByRole('button', { name: 'Confirmar eliminación' }));
  await screen.findByText('Página 1 de 1');
  expect(api.listarProductos.mock.lastCall[0].pagina).toBe(0);
});
it('mantiene el foco en el diálogo y devuelve el foco al cancelar con Escape', async () => {
  const user = await abrir();
  const origen = screen.getByRole('button', { name: 'Eliminar Algoritmos' });
  await user.click(origen);
  const dialogo = screen.getByRole('dialog');
  expect(document.activeElement).toBe(within(dialogo).getByRole('button', { name: 'Cancelar' }));
  await user.tab({ shift: true });
  expect(document.activeElement).toBe(within(dialogo).getByRole('button', { name: 'Confirmar eliminación' }));
  await user.keyboard('{Escape}');
  expect(screen.queryByRole('dialog')).toBeNull();
  expect(document.activeElement).toBe(origen);
});
