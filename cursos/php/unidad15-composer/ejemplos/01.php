<?php
declare(strict_types=1);

namespace Aprende;
final class Etiqueta {
    public static function texto(): string { return "Aprende con Leli"; }
}
echo Etiqueta::texto() . "\n";
echo Etiqueta::class . "\n";
