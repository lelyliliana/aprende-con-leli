# Arquitectura de Aprende con Leli

## Objetivo

Separar la información educativa de la interfaz para que la plataforma pueda crecer sin depender de cursos, tecnologías o instituciones concretas.

## Capas

### 1. Catálogo

Describe qué existe: áreas, cursos, rutas, módulos y recursos.

### 2. Relaciones pedagógicas

Conecta prerrequisitos, continuaciones, cursos relacionados y recursos compartidos. Un mismo recurso puede formar parte de varias rutas sin duplicarse.

### 3. Interfaz

Presentará el catálogo como páginas, tarjetas, rutas y mapas de aprendizaje. La interfaz no debe contener de forma rígida los cursos disponibles.

## Estructura prevista

```text
src/
  data/
    areas.json
    courses.json
    paths.json
  components/
  pages/
  styles/

docs/
  ARQUITECTURA.md
```

Los archivos de `src/data/` serán la fuente del catálogo de la plataforma.

## Modelo de curso

Cada curso podrá registrar:

- identificador estable;
- nombre público;
- descripción;
- área;
- nivel;
- estado de publicación;
- tecnologías;
- prerrequisitos;
- repositorio fuente;
- módulos;
- rutas relacionadas.

## Modelo de ruta

Una ruta no equivale necesariamente a un curso. Puede combinar módulos y recursos procedentes de varios repositorios para alcanzar un objetivo de aprendizaje.

Ejemplos futuros:

- Empieza a programar.
- Desarrollo Frontend.
- Backend con Java.
- Desarrollo Full Stack.
- Python desde cero.
- Git y GitHub para desarrolladores.

## Regla de publicación

El catálogo podrá contener elementos en preparación, pero la interfaz pública solo mostrará aquellos marcados como disponibles.

## Repositorios fuente

Los repositorios educativos existentes permanecen independientes. Esta plataforma los referencia y organiza; no necesita copiarlos ni modificar su estructura.
