<?php
declare(strict_types=1);

function fechaValida(string $texto): bool {
    $fecha = DateTimeImmutable::createFromFormat("!Y-m-d", $texto, new DateTimeZone("America/Bogota"));
    $estado = DateTimeImmutable::getLastErrors();
    if ($fecha === false) { return false; }
    if ($estado !== false && ($estado["warning_count"] > 0 || $estado["error_count"] > 0)) { return false; }
    return $fecha->format("Y-m-d") === $texto;
}
foreach (["2026-02-28", "2026-02-30", "2026-2-3"] as $texto) {
    echo $texto . ": " . (fechaValida($texto) ? "válida" : "inválida") . "\n";
}
