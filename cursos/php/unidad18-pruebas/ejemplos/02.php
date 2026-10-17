<?php
declare(strict_types=1);

function validar(int $cupo): void {
    if ($cupo < 1) { throw new InvalidArgumentException("Cupo inválido"); }
}
$rechazado = false;
try { validar(0); } catch (InvalidArgumentException $e) { $rechazado = true; }
if (!$rechazado) { throw new RuntimeException("Se aceptó un cupo cero"); }
echo "Rechazo comprobado\n";
