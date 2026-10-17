<?php
declare(strict_types=1);

$entrada = "0";
$n = filter_var($entrada, FILTER_VALIDATE_INT);
$valida = $n !== false && $n >= 0 && $n <= 20;
echo $valida ? "Cantidad válida\n" : "Cantidad inválida\n";
