<?php
declare(strict_types=1);

$cantidad = filter_var("0", FILTER_VALIDATE_INT);
echo ($cantidad === false ? "Inválido" : "Entero: $cantidad") . "\n";
$fecha = new DateTimeImmutable("2026-10-17", new DateTimeZone("America/Bogota"));
echo $fecha->modify("+7 days")->format("Y-m-d") . "\n";
