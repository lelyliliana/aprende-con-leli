<?php
declare(strict_types=1);

$sesion = [];
$sesion["flash"] = "Taller guardado";
$mensaje = $sesion["flash"] ?? "";
unset($sesion["flash"]);
echo $mensaje . "\n";
echo isset($sesion["flash"]) ? "Pendiente\n" : "Consumido\n";
