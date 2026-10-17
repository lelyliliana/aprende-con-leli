<?php
declare(strict_types=1);
$defectuosa = in_array('--defectuosa', $argv, true);
$validar = $defectuosa ? fn (int $cupo): bool => $cupo >= 1 && $cupo < 100 : fn (int $cupo): bool => $cupo >= 1 && $cupo <= 100;
$fallos = 0;
foreach ([[0, false], [1, true], [100, true], [101, false]] as [$entrada, $esperado]) {
    $obtenido = $validar($entrada);
    if ($obtenido !== $esperado) { echo "FALLO: cupo $entrada\n"; $fallos++; }
}
echo "Fallos: $fallos\n";
exit($fallos === 0 ? 0 : 1);
