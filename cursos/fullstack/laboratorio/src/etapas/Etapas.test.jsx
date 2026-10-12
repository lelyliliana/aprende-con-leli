import React from 'react';
import { beforeEach, expect, it, vi } from 'vitest';
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import Consulta from './Consulta.jsx';
import Creacion from './Creacion.jsx';
import * as api from '../api.js';
vi.mock('../api.js', () => ({ listarProductos: vi.fn(), listarCategorias: vi.fn(), crearProducto: vi.fn() }));
const pagina = { contenido: [{ id: 1, nombre: 'Libro', categoria: 'Libros', precio: 25 }], total: 1 };
beforeEach(() => { vi.resetAllMocks(); api.listarProductos.mockResolvedValue(pagina); api.listarCategorias.mockResolvedValue([{ id: 1, nombre: 'Libros' }]); });
it('etapa 1 interpreta contenido de una respuesta paginada', async () => {
 render(<Consulta />); await screen.findByText('Libro');
 expect(screen.getByText(/1 productos en total/)).toBeTruthy();
 expect(screen.queryByRole('button', { name: 'Crear producto' })).toBeNull();
});
it('etapa 1 distingue lista vacía y error recuperable', async () => {
 api.listarProductos.mockRejectedValueOnce(new Error('API detenida')).mockResolvedValue({ contenido: [], total: 0 });
 const user=userEvent.setup();render(<Consulta />);await screen.findByText('API detenida');
 await user.click(screen.getByRole('button',{name:'Reintentar consulta'}));await screen.findByText('No hay productos.');
 expect(screen.queryByRole('alert')).toBeNull();
});
async function completar(user) {
 await screen.findByRole('option',{name:'Libros'});
 await user.type(screen.getByLabelText('SKU'),'ETAPA-01');await user.type(screen.getByLabelText('Nombre'),'Libro nuevo');
 await user.type(screen.getByLabelText('Precio'),'30.50');await user.selectOptions(screen.getByLabelText('Categoría'),'1');
}
it('etapa 2 crea con tipos correctos y actualiza la consulta',async()=>{
 api.crearProducto.mockResolvedValue({nombre:'Libro nuevo'});const user=userEvent.setup();render(<Creacion />);await completar(user);
 await user.click(screen.getByRole('button',{name:'Crear producto'}));await screen.findByText('Producto Libro nuevo creado.');
 expect(api.crearProducto).toHaveBeenCalledWith({sku:'ETAPA-01',nombre:'Libro nuevo',precio:30.5,categoriaId:1});
 await waitFor(()=>expect(api.listarProductos.mock.calls.length).toBeGreaterThan(1));
});
it('etapa 2 mantiene el formulario si el SKU ya existe',async()=>{
 api.crearProducto.mockRejectedValue({status:409});const user=userEvent.setup();render(<Creacion />);await completar(user);
 await user.click(screen.getByRole('button',{name:'Crear producto'}));await screen.findByText(/Ya existe ese SKU/);
 expect(screen.getByLabelText('Nombre').value).toBe('Libro nuevo');
});
it('etapa 2 permite reintentar la carga de categorías',async()=>{
 api.listarCategorias.mockRejectedValueOnce(new Error('No hay conexión'));const user=userEvent.setup();render(<Creacion />);
 await screen.findByText('No hay conexión');await user.click(screen.getByRole('button',{name:'Reintentar categorías'}));
 await screen.findByRole('option',{name:'Libros'});expect(screen.getByLabelText('Nombre').closest('fieldset').disabled).toBe(false);
});
