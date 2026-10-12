import React,{useEffect,useState} from 'react';
export default function Recursos(){
 const [modo,setModo]=useState('normal'),[intento,setIntento]=useState(0);
 const [estado,setEstado]=useState('cargando'),[datos,setDatos]=useState([]),[error,setError]=useState('');
 useEffect(()=>{
  const controller=new AbortController();setEstado('cargando');setDatos([]);setError('');
  async function consultar(){
   try{
    const r=await fetch(`./api/recursos?modo=${modo}`,{signal:AbortSignal.any([controller.signal,AbortSignal.timeout(5000)])});
    if(!r.ok)throw new Error(`No se pudieron consultar los recursos (${r.status}).`);
    const lista=await r.json();
    if(!Array.isArray(lista)||!lista.every(item=>typeof item.nombre==='string'&&typeof item.id==='number'))throw new Error('Respuesta inesperada.');
    if(!controller.signal.aborted){setDatos(lista);setEstado('datos');}
   }catch(e){if(!controller.signal.aborted){setError(e.name==='TimeoutError'?'La consulta tardó demasiado. Reintenta.':e instanceof TypeError?'No pudimos conectar con la API. Comprueba el servidor.':e.message);setEstado('error');}}
  }
  consultar();return()=>controller.abort();
 },[modo,intento]);
 return <section className="tarjeta" aria-labelledby="recursos-title"><h2 id="recursos-title">Recursos de estudio (API local de práctica)</h2><label htmlFor="modo">Respuesta para experimentar</label><select id="modo" value={modo} onChange={e=>setModo(e.target.value)}><option value="normal">Con recursos</option><option value="vacio">Sin recursos</option><option value="error">Fallo del servidor</option></select>
 {estado==='cargando'&&<p role="status">Consultando recursos…</p>}
 {estado==='error'&&<p role="alert" className="error">{error} <button onClick={()=>setIntento(n=>n+1)}>Reintentar recursos</button></p>}
 {estado==='datos'&&(datos.length?<ul>{datos.map(d=><li key={d.id}>{d.nombre}</li>)}</ul>:<p>No hay recursos disponibles.</p>)}
 <p>El endpoint existe en dev y preview. Para publicar esta vista necesitas una API disponible en el destino.</p></section>;
}
