import {act} from '@testing-library/react';
import React from 'react';import {afterEach,expect,it,vi} from 'vitest';import {render,screen} from '@testing-library/react';import userEvent from '@testing-library/user-event';import Recursos from './Recursos.jsx';
afterEach(()=>vi.unstubAllGlobals());
it('presenta recursos reales de la respuesta controlada',async()=>{vi.stubGlobal('fetch',vi.fn().mockResolvedValue(new Response('[{"id":1,"nombre":"HTML"}]',{headers:{'content-type':'application/json'}})));render(<Recursos/>);await screen.findByText('HTML');});
it('distingue vacío de fallo HTTP y permite reintentar',async()=>{const mock=vi.fn().mockResolvedValueOnce(new Response('[]',{headers:{'content-type':'application/json'}})).mockResolvedValueOnce(new Response('{}',{status:503})).mockResolvedValue(new Response('[]',{headers:{'content-type':'application/json'}}));vi.stubGlobal('fetch',mock);const user=userEvent.setup();render(<Recursos/>);await screen.findByText('No hay recursos disponibles.');await user.selectOptions(screen.getByLabelText('Respuesta para experimentar'),'error');expect((await screen.findByRole('alert')).textContent).toContain('503');await user.click(screen.getByRole('button',{name:'Reintentar recursos'}));await screen.findByText('No hay recursos disponibles.');});
it('rechaza una respuesta JSON incompatible',async()=>{vi.stubGlobal('fetch',vi.fn().mockResolvedValue(new Response('{"datos":[]}',{headers:{'content-type':'application/json'}})));render(<Recursos/>);expect((await screen.findByRole('alert')).textContent).toContain('Respuesta inesperada');});


it('una respuesta anterior tardía no reemplaza el error de la consulta actual', async () => {
 let resolverAnterior;
 const anterior = new Promise(resolve => { resolverAnterior = resolve; });
 const mock = vi.fn().mockReturnValueOnce(anterior).mockResolvedValue(new Response('{}', {status:503}));
 vi.stubGlobal('fetch', mock);
 const user = userEvent.setup();
 render(<Recursos/>);
 await user.selectOptions(screen.getByLabelText('Respuesta para experimentar'), 'error');
 expect((await screen.findByRole('alert')).textContent).toContain('503');
 await act(async () => {
  resolverAnterior(new Response('[{"id":1,"nombre":"Respuesta anterior"}]'));
 });
 expect(screen.queryByText('Respuesta anterior')).toBeNull();
 expect(screen.getByRole('alert').textContent).toContain('503');
});
