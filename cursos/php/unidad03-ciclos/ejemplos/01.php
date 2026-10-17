<?php
declare(strict_types=1);

$total = 0;
for ($sesion = 1; $sesion <= 3; $sesion++) {
    $total += $sesion;
    echo "Sesión $sesion: $total\n";
}
