import assert from 'node:assert/strict';
const origen=process.env.LAB_ORIGIN||'http://127.0.0.1:5174';
for(const page of ['index.html','javascript.html','react.html']){
 const r=await fetch(`${origen}/${page}`,{signal:AbortSignal.timeout(5000)});assert.equal(r.status,200);const html=await r.text();assert.ok(html.includes('Mi plan de estudio'));assert.ok(html.includes('estilos'));
}
for(const [modo,status,cantidad] of [['normal',200,2],['vacio',200,0],['error',503,null]]){
 const r=await fetch(`${origen}/api/recursos?modo=${modo}`,{signal:AbortSignal.timeout(5000)});assert.equal(r.status,status);const data=await r.json();if(cantidad!==null)assert.equal(data.length,cantidad);
}
const r=await fetch(`${origen}/api/recursos`,{method:'POST',signal:AbortSignal.timeout(5000)});assert.equal(r.status,405);assert.equal(r.headers.get('allow'),'GET');
console.log('HTTP correcto: tres páginas, recursos normales/vacíos/error y método rechazado.');
