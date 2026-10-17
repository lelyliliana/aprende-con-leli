<?php
declare(strict_types=1);

function subtotal(int $precioCentavos, int $cantidad): int {
    return $precioCentavos * $cantidad;
}
echo subtotal(2500, 3) . "\n";
