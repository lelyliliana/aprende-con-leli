<?php
declare(strict_types=1);

$temas = ["PHP", "HTML"];
$temas[] = "SQL";
foreach ($temas as $indice => $tema) {
    echo "$indice: $tema\n";
}
