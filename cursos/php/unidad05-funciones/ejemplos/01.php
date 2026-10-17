<?php
declare(strict_types=1);

function plazasDisponibles(int $capacidad, int $inscritos): int {
    return max(0, $capacidad - $inscritos);
}
echo plazasDisponibles(12, 5) . "\n";
echo plazasDisponibles(5, 8) . "\n";
