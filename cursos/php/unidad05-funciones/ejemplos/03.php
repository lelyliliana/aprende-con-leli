<?php
declare(strict_types=1);

function subtotalCentavos(int $precio, int $cantidad): int {
    return $precio * $cantidad;
}
function totalConEnvio(int $subtotal, int $envio = 0): int {
    return $subtotal + $envio;
}
$materiales = subtotalCentavos(1250, 3);
$total = totalConEnvio($materiales, 500);
echo "Materiales: $materiales\n";
echo "Total con envío: $total\n";
