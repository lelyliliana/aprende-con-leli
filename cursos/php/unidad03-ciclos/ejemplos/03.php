<?php
declare(strict_types=1);

$materiales = 12;
$entregados = 0;
for ($grupo = 1; $grupo <= 3; $grupo++) {
    $entregados += 2;
    $materiales -= 2;
    echo "Grupo $grupo: entregados=$entregados; quedan=$materiales\n";
}
echo "Grupos procesados: " . ($grupo - 1) . "\n";
