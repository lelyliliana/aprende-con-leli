<?php
declare(strict_types=1);

function leerConfiguracion(string $texto): array {
    $datos = json_decode($texto, true, 512, JSON_THROW_ON_ERROR);
    if (!is_array($datos)) { throw new InvalidArgumentException("La configuración debe ser un arreglo"); }
    return $datos;
}
try {
    leerConfiguracion("null");
    echo "Configuración cargada\n";
} catch (InvalidArgumentException $e) {
    echo "Rechazada: " . $e->getMessage() . "\n";
} finally {
    echo "Recurso de práctica liberado\n";
}
