<?php
declare(strict_types=1);

$entorno = getenv("LELI_ENTORNO_EJEMPLO");
$entorno = $entorno === false ? "local" : $entorno;
echo in_array($entorno, ["local", "production"], true) ? "Configuración reconocida\n" : "Configuración inválida\n";
