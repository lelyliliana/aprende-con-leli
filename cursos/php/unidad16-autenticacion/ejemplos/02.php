<?php
declare(strict_types=1);

$usuario = ["id" => 7, "rol" => "lector"];
$autenticado = isset($usuario["id"]);
$puedeEditar = $autenticado && $usuario["rol"] === "administrador";
echo $autenticado ? "Identidad conocida\n" : "Sin sesión\n";
echo $puedeEditar ? "Puede editar\n" : "403: sin permiso\n";
