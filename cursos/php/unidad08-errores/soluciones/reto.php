<?php
declare(strict_types=1);

function dividir(float $a, float $b): float {
    if ($b === 0.0) { throw new InvalidArgumentException("Divisor cero"); }
    return $a / $b;
}
try { echo dividir(10.0, 0.0); }
catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
