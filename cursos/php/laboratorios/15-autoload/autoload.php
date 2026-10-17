<?php
declare(strict_types=1);
spl_autoload_register(function (string $clase): void {
    $prefijo = 'AprendeLab\\';
    if (!str_starts_with($clase, $prefijo)) { return; }
    $relativa = substr($clase, strlen($prefijo));
    // Contrato del ejercicio: solo estos dos nombres, nunca rutas de una petición.
    if (!in_array($relativa, ['Saludo', 'Informe'], true)) { return; }
    require_once __DIR__ . '/src/' . $relativa . '.php';
});
