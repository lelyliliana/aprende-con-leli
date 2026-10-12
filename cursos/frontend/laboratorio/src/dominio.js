export function validarTitulo(value) {
 const titulo=String(value).trim();
 if(!titulo || titulo.length>80) throw new Error('Escribe un título de 1 a 80 caracteres.');
 return titulo;
}
export function agregar(tareas,titulo,id=crypto.randomUUID()) {
 if(tareas.length>=100) throw new Error('El plan admite hasta 100 tareas.');
 if(tareas.some(t=>t.id===id)) throw new Error('El identificador ya existe.');
 return [...tareas,{id,titulo:validarTitulo(titulo),completa:false}];
}
export function alternar(tareas,id) {
 if(!tareas.some(t=>t.id===id))throw new Error('La tarea ya no existe.');
 return tareas.map(t=>t.id===id?{...t,completa:!t.completa}:t);
}
export function eliminar(tareas,id) {
 if(!tareas.some(t=>t.id===id))throw new Error('La tarea ya no existe.');
 return tareas.filter(t=>t.id!==id);
}
export function filtrar(tareas,filtro) {
 return tareas.filter(t=>filtro==='todas'||(filtro==='completas'?t.completa:!t.completa));
}
