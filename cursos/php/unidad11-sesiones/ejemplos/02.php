<?php
declare(strict_types=1);

$esperado = str_repeat("a", 64); // Solo para reproducir esta prueba.
$recibido = str_repeat("b", 64);
$valido = is_string($recibido) && hash_equals($esperado, $recibido);
echo $valido ? "Permitido\n" : "403: token inválido\n";
