<?php
declare(strict_types=1);

$criterios = ["Crear un taller válido", "Rechazar cupo cero", "Conservar datos al reiniciar"];
foreach ($criterios as $indice => $criterio) { echo ($indice + 1) . ". $criterio\n"; }
