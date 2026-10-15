import { defineConfig } from 'vitest/config';
import { fileURLToPath } from 'node:url';
function middleware(req,res,next){
 const url=new URL(req.url,'http://localhost');
 if(url.pathname!=='/api/recursos')return next();
 res.setHeader('Content-Type','application/json; charset=utf-8');
 if(req.method!=='GET'){res.statusCode=405;res.setHeader('Allow','GET');res.end(JSON.stringify({mensaje:'Método no permitido'}));return;}
 const modo=url.searchParams.get('modo');
 if(modo==='error'){res.statusCode=503;res.end(JSON.stringify({mensaje:'Fallo controlado'}));return;}
 res.end(JSON.stringify(modo==='vacio'?[]:[{id:1,nombre:'Practicar formularios HTML'},{id:2,nombre:'Repasar efectos React'}]));
}
const apiLocal={name:'api-local-recursos',configureServer(server){server.middlewares.use(middleware);},configurePreviewServer(server){server.middlewares.use(middleware);}};
export default defineConfig({
 plugins:[apiLocal],
 base:'./',
 server:{host:'127.0.0.1',port:5174,strictPort:true},
 preview:{host:'127.0.0.1',port:4174,strictPort:true},
 build:{rollupOptions:{input:Object.fromEntries(['index','javascript','react','pasos/index','pasos/01-html','pasos/02-css','pasos/03-memoria','pasos/04-guardado','pasos/05-react'].map(name=>[name,fileURLToPath(new URL(`./${name}.html`,import.meta.url))]))}},
 test:{environment:'jsdom',setupFiles:'./src/test-setup.js'}
});
