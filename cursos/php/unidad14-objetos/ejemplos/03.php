<?php
declare(strict_types=1);

final class ContadorPlazas {
    public function __construct(public int $plazas) {}
}
$original = new ContadorPlazas(12);
$otroNombre = $original;
$otroNombre->plazas = 10;
$copia = clone $original;
$copia->plazas = 8;
echo "Original: $original->plazas\n";
echo "Otro nombre: $otroNombre->plazas\n";
echo "Copia: $copia->plazas\n";
