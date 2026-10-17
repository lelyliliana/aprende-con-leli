<?php
declare(strict_types=1);

function subtotal(int $precio, int $cantidad): int {
    if ($precio < 0 || $cantidad < 0) { throw new InvalidArgumentException("No se aceptan negativos"); }
    return $precio * $cantidad;
}
try { echo subtotal(2500, -1); }
catch (InvalidArgumentException $error) { echo $error->getMessage() . "\n"; }
