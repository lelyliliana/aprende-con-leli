<?php
declare(strict_types=1);

$edad = 11; $inscritos = 9; $capacidad = 10;
echo "11 años, 9 inscritos: " . ($edad >= 12 && $inscritos < $capacidad ? "admitir" : "rechazar") . "\n";
$edad = 12;
echo "12 años, 9 inscritos: " . ($edad >= 12 && $inscritos < $capacidad ? "admitir" : "rechazar") . "\n";
$inscritos = 10;
echo "12 años, 10 inscritos: " . ($edad >= 12 && $inscritos < $capacidad ? "admitir" : "rechazar") . "\n";
$inscritos = 11;
echo "12 años, 11 inscritos: " . ($edad >= 12 && $inscritos < $capacidad ? "admitir" : "rechazar") . "\n";
