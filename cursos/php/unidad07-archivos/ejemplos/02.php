<?php
declare(strict_types=1);

$archivo = fopen('php://memory', 'w+');
fputcsv($archivo, ['PHP, nivel inicial', '12'], ',', '"', '');
rewind($archivo);
$fila = fgetcsv($archivo, 0, ',', '"', '');
fclose($archivo);
echo $fila[0] . ' | ' . $fila[1] . "\n";
