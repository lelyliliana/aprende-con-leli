<?php
declare(strict_types=1);

$ruta = tempnam(sys_get_temp_dir(), "leli-");
if ($ruta === false) { throw new RuntimeException("No se pudo crear el temporal"); }
try {
    $texto = json_encode(["titulo" => "PHP"], JSON_THROW_ON_ERROR);
    if (file_put_contents($ruta, $texto) === false) { throw new RuntimeException("No se pudo escribir"); }
    $leido = file_get_contents($ruta);
    if ($leido === false) { throw new RuntimeException("No se pudo leer"); }
    echo json_decode($leido, true, 512, JSON_THROW_ON_ERROR)["titulo"] . "\n";
} finally { unlink($ruta); }
