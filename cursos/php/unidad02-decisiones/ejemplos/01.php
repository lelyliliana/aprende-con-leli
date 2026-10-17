<?php
declare(strict_types=1);

$inscritos = 10;
$capacidad = 10;
if ($inscritos < $capacidad) {
    echo "Hay cupo\n";
} else {
    echo "Taller completo\n";
}
