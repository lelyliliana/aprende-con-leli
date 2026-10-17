<?php
declare(strict_types=1);

interface Contador { public function total(): int; }
final class ContadorFijo implements Contador {
    public function total(): int { return 3; }
}
function resumen(Contador $contador): string { return "Talleres: " . $contador->total(); }
echo resumen(new ContadorFijo()) . "\n";
