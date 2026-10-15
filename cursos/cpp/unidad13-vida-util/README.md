# Unidad 13. Alcance, punteros y vida útil

[Anterior](../unidad12-clases/README.md) · [Índice](../README.md) · [Siguiente](../unidad14-propiedad/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Vincular una referencia.
- Observar por puntero.
- Representar ausencia.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Un nombre, una dirección y una vida útil

Hasta ahora has usado valores y referencias. Un puntero puede observar la ubicación de un objeto. int* observador=&cantidad obtiene una dirección; *observador accede al entero cuando el puntero es válido. & en esta expresión obtiene una dirección, mientras & en una declaración de referencia vincula un alias. Lee el contexto para distinguirlos.

### Una referencia y un puntero no expresan lo mismo

La referencia de este ejemplo se vincula al objeto y se utiliza como otro nombre. El puntero puede cambiar y tomar nullptr para indicar que no observa un objeto. Antes de desreferenciar un puntero que admite ausencia, comprueba ese caso. No uses una dirección nula para «ver qué imprime»: incumple la precondición de acceso.

El puntero del ejemplo no es propietario de cantidad. No debes aplicarle delete: la variable automática tiene otra gestión de vida útil. Tener una dirección no significa tener la responsabilidad del almacenamiento.

### Alcance y vida útil están relacionados, pero no son sinónimos universales

El alcance determina dónde se puede usar un nombre. La vida útil determina cuándo existe el objeto para acceder válidamente. Las variables automáticas del bloque se destruyen al terminarlo. Un objeto dinámico o almacenamiento compartido requiere analizar otra duración; en la siguiente unidad usaremos propietarios que hagan explícita esa responsabilidad.

En el recurso de demostración, el constructor imprime adquisición y el destructor liberación. El orden muestra que la liberación sucede al salir del bloque, antes del mensaje siguiente. Esa clase solo representa el recorrido con mensajes; no abre un archivo real ni comprueba un recurso externo.

| Paso | ¿Existe el recurso local? |
|---|---|
| Antes del bloque | No |
| Tras construir dentro | Sí |
| Al terminar el bloque | Se destruye |
| Después del bloque | No puede usarse a través de un observador guardado |

### Evita observadores colgantes

Devolver la dirección de un entero local no lo conserva al terminar la función. Guardar una referencia a un elemento de vector y conservarla mientras se reasigna su almacenamiento también puede invalidarla. Los bytes que parezcan permanecer en memoria no acreditan que el objeto siga existiendo.

No incluimos accesos inválidos deliberados en los programas ejecutables. Se explica la causa y se construye una alternativa válida: devolver un valor, conservar un propietario de vida útil suficiente o volver a obtener un observador después de modificar el contenedor.

### RAII conecta alcance y recurso

RAII vincula recursos a objetos que los adquieren y liberan mediante su vida útil. string y vector ya gestionan su almacenamiento de esa manera; los flujos de archivo añadirán otro ejemplo. La idea no es escribir un destructor para cada clase, sino componer objetos cuyos miembros ya se encarguen correctamente de sus recursos.

Una comprobación contra nullptr detecta ausencia, no un puntero colgante no nulo. La corrección depende también de la vida útil y las reglas de invalidación, no solo de si la dirección es distinta de cero.

## Ejemplo 1. Un puntero observa un objeto existente

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

int main() {
    int cantidad{5};
    int* observador{&cantidad};
    if (observador != nullptr) { *observador = 7; }
    std::cout << "Cantidad: " << cantidad << '\n';
    observador = nullptr;
    std::cout << std::boolalpha << "Sin objeto observado: " << (observador == nullptr) << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u13_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u13_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u13_e01.exe` |

Salida esperada:

```text
Cantidad: 7
Sin objeto observado: true
```

### Lectura paso a paso

cantidad vive durante main. El puntero observa ese entero y lo cambia a 7. Después se asigna nullptr al puntero; el entero todavía existe y no se destruye por esa asignación. Se cambió el observador, no la propiedad del objeto.

## Ejemplo 2. El alcance determina la destrucción

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <string>
#include <utility>

class Recurso {
    std::string nombre_;
public:
    explicit Recurso(std::string nombre) : nombre_{nombre} { std::cout << "Adquirir: " << nombre_ << '\n'; }
    ~Recurso() { std::cout << "Liberar: " << nombre_ << '\n'; }
};

int main() {
    std::cout << "Antes del bloque\n";
    {
        const Recurso recurso{"archivo de práctica"};
        std::cout << "Dentro del bloque\n";
    }
    std::cout << "Después del bloque\n";
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u13_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u13_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u13_e02.exe` |

Salida esperada:

```text
Antes del bloque
Adquirir: archivo de práctica
Dentro del bloque
Liberar: archivo de práctica
Después del bloque
```

### Lectura paso a paso

Los mensajes aparecen antes del bloque, adquirir, dentro, liberar y después. El destructor se ejecuta al terminar el alcance del objeto local. No se imprime una dirección variable entre ejecuciones: la lección se centra en el orden de vida útil.

## Experimenta

Dibuja cantidad, alias y puntero de la solución e identifica quién es propietario. Luego añade un elemento a un vector antes de obtener la dirección de su primero. Explica por qué obtenerla antes y guardarla a través de un crecimiento requeriría revisar invalidación.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Aplicar delete a un objeto automático | Un observador no adquiere propiedad por guardar su dirección. |
| Comprobar solo nullptr | También debes garantizar vida útil válida. |
| Usar un local después de salir de su bloque | Devuelve un valor o conserva un propietario adecuado. |

## Autoevaluación

1. ¿Un puntero siempre es dueño?
2. ¿nullptr detecta todos los accesos inválidos?
3. ¿Qué muestra el destructor del recurso?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad12-clases/README.md) · [Índice](../README.md) · [Siguiente](../unidad14-propiedad/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2013%20%28Alcance%2C%20punteros%20y%20vida%20%C3%BAtil%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
