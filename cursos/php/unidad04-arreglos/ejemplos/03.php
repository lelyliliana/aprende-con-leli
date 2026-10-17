<?php
declare(strict_types=1);

$temas = ["PHP", "HTML", "SQL"];
unset($temas[1]);
foreach ($temas as $clave => $tema) { echo "$clave: $tema\n"; }
$copia = array_values($temas);
$copia[0] = "Web";
echo "Original: " . $temas[0] . "\n";
echo "Copia: " . $copia[0] . "\n";
$taller = ["aula" => null];
echo array_key_exists("aula", $taller) ? "Clave presente\n" : "Clave ausente\n";
echo isset($taller["aula"]) ? "Valor asignado\n" : "Valor pendiente\n";
