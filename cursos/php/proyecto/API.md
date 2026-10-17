# Contrato de la API de talleres

[Proyecto](README.md)

**GET /api/talleres** requiere una sesión administrativa activa en el mismo origen. Inicia sesión en la interfaz y abre el enlace a la API desde ese navegador. No envíes claves en la URL. La API no acepta escrituras.

| Parámetro | Tipo | Reglas |
|---|---|---|
| q | cadena opcional | Subcadena literal de hasta 100 caracteres; por defecto vacía |
| page | entero positivo como texto | De 1 a 100000; por defecto 1 |

Cada página tiene hasta diez filas, ordenadas por ID descendente. Una página fuera del conjunto pero dentro del rango admitido devuelve data vacía. El filtro usa comparación sin distinción de mayúsculas ASCII; no promete normalización Unicode completa.

Respuesta 200, Content-Type application/json; charset=utf-8:

```json
{"data":[{"id":1,"titulo":"PHP inicial","cupo":12}],"page":1,"per_page":10,"total":1}
```

| Estado | Causa |
|---|---|
| 200 | Lectura correcta, incluso sin resultados |
| 400 | Filtro o página de tipo o rango inválido |
| 401 | No existe sesión administrativa válida |
| 405 | Método distinto de GET; cabecera Allow: GET |
| 500 | Fallo interno o configuración de base incorrecta |

Ejemplo de error:

```json
{"error":{"status":401,"message":"Inicia sesión para consultar la API."}}
```

La API no incluye usuarios, hashes ni tokens de sesión en el cuerpo. Cache-Control: no-store evita almacenar la representación como una respuesta pública en caché. Las pruebas en scripts/verificar_http.py muestran cómo un cliente conserva cookies sin imprimir sus valores.
