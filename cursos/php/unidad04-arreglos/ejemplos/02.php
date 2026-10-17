<?php
declare(strict_types=1);

$talleres = [["titulo" => "PHP", "cupo" => 12], ["titulo" => "Web", "cupo" => 8]];
$total = 0;
foreach ($talleres as $taller) { $total += $taller["cupo"]; }
echo "Plazas: $total\n";
echo ($talleres[0]["aula"] ?? "Aula pendiente") . "\n";
