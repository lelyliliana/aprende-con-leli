<?php
declare(strict_types=1);

$casos = [[0, 0], [1, 2500], [3, 7500]];
foreach ($casos as [$cantidad, $esperado]) {
    $obtenido = 2500 * $cantidad;
    if ($obtenido !== $esperado) { throw new RuntimeException("Cantidad: $cantidad"); }
}
echo "3 casos correctos\n";
