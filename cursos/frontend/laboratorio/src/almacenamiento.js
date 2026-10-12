export const CLAVE='leli.frontend.plan.v1';
export function cargar(storage) {
 try {
  const medio=storage ?? globalThis.localStorage;
  const text=medio.getItem(CLAVE); if(text===null)return {tareas:[],error:''};
  const datos=JSON.parse(text);
  if(datos.version!==1||!Array.isArray(datos.tareas)||datos.tareas.length>100)throw new Error();
  const ids=new Set();
  for(const t of datos.tareas){
   if(typeof t.id!=='string'||!t.id||ids.has(t.id)||typeof t.titulo!=='string'||!t.titulo.trim()||t.titulo.length>80||typeof t.completa!=='boolean')throw new Error();
   ids.add(t.id);
  }
  return {tareas:datos.tareas.map(t=>({id:t.id,titulo:t.titulo,completa:t.completa})),error:''};
 } catch {return {tareas:[],error:'No pudimos leer el plan guardado. Conservamos el contenido original; corrígelo en el almacenamiento antes de agregar tareas.'};}
}
export function guardar(tareas,storage){
 try{const medio=storage ?? globalThis.localStorage;medio.setItem(CLAVE,JSON.stringify({version:1,tareas}));return '';}
 catch{return 'El cambio está en esta sesión, pero no pudimos guardarlo. No cierres la página si necesitas conservarlo.';}
}
