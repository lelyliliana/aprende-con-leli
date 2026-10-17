<?php
declare(strict_types=1);

$codigo = "007";
$cantidad = 2;
$totalCentavos = 4500 * $cantidad;
$cantidad += 1;
echo get_debug_type($codigo) . ": $codigo\n";
echo "Cantidad actual: $cantidad\n";
echo "Total guardado: $totalCentavos\n";
echo 'Literal: $cantidad' . "\n";
