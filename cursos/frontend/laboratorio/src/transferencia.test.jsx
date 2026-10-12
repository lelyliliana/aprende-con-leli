import React from 'react';import {readFileSync} from 'node:fs';import {expect,it} from 'vitest';import {render,screen} from '@testing-library/react';import userEvent from '@testing-library/user-event';import App from './App.jsx';import {cargar} from './almacenamiento.js';
it('JavaScript real guarda texto seguro que React vuelve a leer',async()=>{
 const html=readFileSync('javascript.html','utf8');
 document.body.innerHTML=html.match(/<body>([\s\S]*)<\/body>/)[1];
 await import('./javascript.js');const user=userEvent.setup();
 await user.type(screen.getByLabelText('¿Qué vas a estudiar?'),'<img src=x>');
 await user.click(screen.getByRole('button',{name:'Agregar tarea'}));
 expect(cargar().tareas[0].titulo).toBe('<img src=x>');expect(document.querySelector('#lista img')).toBeNull();
 document.body.replaceChildren();render(<App/>);
 expect(screen.getByText('<img src=x>')).toBeTruthy();await user.click(screen.getByRole('checkbox'));expect(cargar().tareas[0].completa).toBe(true);
});
