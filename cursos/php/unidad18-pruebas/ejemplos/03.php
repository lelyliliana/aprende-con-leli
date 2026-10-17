<?php
declare(strict_types=1);

$casos = [[1, true], [100, true], [0, false], [101, false]];
$correcta = fn (int $cupo): bool => $cupo >= 1 && $cupo <= 100;
$defectuosa = fn (int $cupo): bool => $cupo >= 1 && $cupo < 100;
foreach (["Correcta" => $correcta, "Defectuosa" => $defectuosa] as $nombre => $regla) {
    $fallos = 0;
    foreach ($casos as [$entrada, $esperado]) {
        if ($regla($entrada) !== $esperado) { $fallos++; }
    }
    echo "$nombre: $fallos fallos\n";
}
