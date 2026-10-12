import React,{useRef,useState} from 'react';
import {agregar,alternar,eliminar,filtrar} from './dominio.js';
import {cargar,guardar} from './almacenamiento.js';
export default function App(){
 const [inicio]=useState(()=>cargar());
 const [tareas,setTareas]=useState(inicio.tareas);
 const [titulo,setTitulo]=useState('');const [filtro,setFiltro]=useState('todas');
 const [error,setError]=useState(inicio.error);const [mensaje,setMensaje]=useState('');
 const campo=useRef(null);
 function aplicar(cambio,texto){
  if(inicio.error)return;
  try{const nuevas=cambio(tareas);setTareas(nuevas);setError(guardar(nuevas));setMensaje(texto);campo.current?.focus();return true;}
  catch(e){setError(e.message);return false;}
 }
 function enviar(e){e.preventDefault();if(aplicar(t=>agregar(t,titulo),'Tarea agregada.'))setTitulo('');}
 return <>
  {error&&<p className="error" role="alert">{error}</p>}
  <form onSubmit={enviar}><label htmlFor="titulo">¿Qué vas a estudiar?</label><div className="acciones"><input ref={campo} id="titulo" value={titulo} onChange={e=>setTitulo(e.target.value)} required maxLength={80} disabled={Boolean(inicio.error)}/><button disabled={Boolean(inicio.error)}>Agregar tarea</button></div></form>
  <p role="status">{mensaje}</p><p>{tareas.filter(t=>!t.completa).length} tareas pendientes de {tareas.length}.</p>
  <label htmlFor="filtro">Mostrar</label><select id="filtro" value={filtro} onChange={e=>setFiltro(e.target.value)}><option value="todas">Todas</option><option value="pendientes">Pendientes</option><option value="completas">Completas</option></select>
  {filtrar(tareas,filtro).length===0?<p>No hay tareas para este filtro.</p>:<ul>{filtrar(tareas,filtro).map(t=><li key={t.id}><label><input type="checkbox" checked={t.completa} onChange={()=>aplicar(ts=>alternar(ts,t.id),'Estado actualizado.')} disabled={Boolean(inicio.error)}/><span>{t.titulo}</span></label><button className="secundario" onClick={()=>aplicar(ts=>eliminar(ts,t.id),'Tarea eliminada.')} disabled={Boolean(inicio.error)} aria-label={`Eliminar ${t.titulo}`}>Eliminar</button></li>)}</ul>}
 </>;
}
