<?php
declare(strict_types=1);
namespace AprendeLab;
final class Informe {
    public function __construct(private Saludo $saludo) {}
    public function linea(): string { return $this->saludo->mensaje('Leli') . '; clases cargadas por demanda'; }
}
