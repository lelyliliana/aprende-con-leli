<?php
declare(strict_types=1);

$titulos = ["PHP", "HTML", "SQL", "CSS", "Git"];
$pagina = 2;
$porPagina = 2;
$inicio = ($pagina - 1) * $porPagina;
echo implode(", ", array_slice($titulos, $inicio, $porPagina)) . "\n";
