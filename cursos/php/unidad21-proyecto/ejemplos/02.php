<?php
declare(strict_types=1);

$evidencias = ["crud" => true, "seguridad" => true, "pruebas" => false];
$completa = !in_array(false, $evidencias, true);
echo $completa ? "Lista para revisar\n" : "Faltan evidencias\n";
