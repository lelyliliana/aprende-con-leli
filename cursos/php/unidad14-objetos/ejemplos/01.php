<?php
declare(strict_types=1);

final class Taller {
    public function __construct(public readonly string $titulo, public readonly int $cupo) {
        if ($cupo < 1) { throw new InvalidArgumentException("Cupo inválido"); }
    }
}
$taller = new Taller("PHP", 12);
echo "$taller->titulo: $taller->cupo plazas\n";
