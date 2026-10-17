<?php
declare(strict_types=1);

$casos = ["Categoría permitida" => "aceptar", "Categoría ausente" => "rechazar", "Categoría desconocida" => "rechazar"];
foreach ($casos as $entrada => $esperado) { echo "$entrada: $esperado\n"; }
