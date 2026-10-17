<?php
declare(strict_types=1);

$talleres = [["titulo" => "PHP", "cupo" => 0], ["titulo" => "Web", "cupo" => 8]];
$abiertos = [];
foreach ($talleres as $taller) {
    if ($taller["cupo"] > 0) { $abiertos[] = $taller["titulo"]; }
}
echo implode(", ", $abiertos) . "\n";
