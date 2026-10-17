<?php
declare(strict_types=1);

function comprobar(bool $condicion, string $mensaje): void {
    if (!$condicion) { throw new RuntimeException($mensaje); }
}
function total(int $precio, int $cantidad): int { return $precio * $cantidad; }
comprobar(total(2500, 3) === 7500, "Subtotal incorrecto");
comprobar(total(2500, 0) === 0, "Caso cero incorrecto");
echo "2 comprobaciones correctas\n";
