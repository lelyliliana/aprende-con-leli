<?php
declare(strict_types=1);

$estado = "abierto";
$mensaje = match ($estado) {
    "abierto" => "Puedes inscribirte",
    "cerrado" => "Inscripción cerrada",
    default => "Estado desconocido",
};
echo $mensaje . "\n";
echo (5 === "5" ? "Iguales" : "Tipos distintos") . "\n";
