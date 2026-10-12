import {agregar,alternar,eliminar,filtrar} from './dominio.js';
import {cargar,guardar} from './almacenamiento.js';
const inicio=cargar();let tareas=inicio.tareas;
const form=document.querySelector('form'),campo=document.querySelector('#titulo'),lista=document.querySelector('#lista'),filtro=document.querySelector('#filtro');
const error=document.querySelector('#error'),mensaje=document.querySelector('#mensaje'),resumen=document.querySelector('#resumen');
function aplicar(cambio,texto){
 if(inicio.error)return false;
 try{tareas=cambio(tareas);error.textContent=guardar(tareas);mensaje.textContent=texto;render();campo.focus();return true;}
 catch(e){error.textContent=e.message;return false;}
}
function render(){
 lista.replaceChildren();resumen.textContent=`${tareas.filter(t=>!t.completa).length} tareas pendientes de ${tareas.length}.`;
 const visibles=filtrar(tareas,filtro.value);
 if(!visibles.length){const li=document.createElement('li');li.textContent='No hay tareas para este filtro.';lista.append(li);}
 for(const t of visibles){
  const li=document.createElement('li'),label=document.createElement('label'),check=document.createElement('input'),texto=document.createElement('span'),button=document.createElement('button');
  check.type='checkbox';check.checked=t.completa;check.disabled=Boolean(inicio.error);texto.textContent=t.titulo;
  check.addEventListener('change',()=>aplicar(ts=>alternar(ts,t.id),'Estado actualizado.'));
  button.textContent='Eliminar';button.className='secundario';button.disabled=Boolean(inicio.error);button.setAttribute('aria-label',`Eliminar ${t.titulo}`);
  button.addEventListener('click',()=>aplicar(ts=>eliminar(ts,t.id),'Tarea eliminada.'));
  label.append(check,texto);li.append(label,button);lista.append(li);
 }
}
error.textContent=inicio.error;
if(inicio.error){campo.disabled=true;form.querySelector('button').disabled=true;}
form.addEventListener('submit',e=>{e.preventDefault();if(aplicar(ts=>agregar(ts,campo.value),'Tarea agregada.'))campo.value='';});
filtro.addEventListener('change',render);render();
