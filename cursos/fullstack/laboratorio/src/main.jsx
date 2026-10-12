import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App.jsx';
import Consulta from './etapas/Consulta.jsx';
import Creacion from './etapas/Creacion.jsx';
import './styles.css';

const parametro = new URLSearchParams(window.location.search).get('etapa');
const etapa = ['1', '2'].includes(parametro) ? parametro : '3';
const nombres = { '1': 'Consultar la API', '2': 'Crear y consultar', '3': 'Catálogo completo' };
const contenido = etapa === '1' ? <Consulta /> : <Creacion />;

const navigation = <nav className="contenedor etapas" aria-label="Etapas del laboratorio">
  {Object.entries(nombres).map(([numero, nombre]) => <a key={numero} href={`?etapa=${numero}`} aria-current={etapa === numero ? 'page' : undefined}>{numero}. {nombre}</a>)}
</nav>;

createRoot(document.getElementById('root')).render(<React.StrictMode>
  {etapa === '3' ? <App navigation={navigation} /> : <>
    {navigation}
    <header className="cabecera"><div className="contenedor"><p className="marca">APRENDE CON LELI · PRÁCTICA PROGRESIVA</p><h1>{nombres[etapa]}</h1><p>Comprende una operación a la vez antes de integrar el catálogo completo.</p></div></header>
    <main className="contenedor"><p className="nota">Datos ficticios locales. La consulta inicial muestra hasta cinco productos; búsqueda y paginación se estudian en la etapa 3.</p>{contenido}<footer>La API y la base son las mismas en las tres etapas.</footer></main>
  </>}
</React.StrictMode>);
