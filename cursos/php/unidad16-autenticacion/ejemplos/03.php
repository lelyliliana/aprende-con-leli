<?php
declare(strict_types=1);

function permite(?array $usuario, string $accion): bool {
    if ($usuario === null) { return false; }
    $permisos = ["lector" => ["leer"], "administrador" => ["leer", "crear", "editar", "eliminar"]];
    $rol = $usuario["rol"] ?? null;
    if (!is_string($rol)) { return false; }
    return in_array($accion, $permisos[$rol] ?? [], true);
}
echo permite(null, "leer") ? "Permitido\n" : "Denegado\n";
echo permite(["rol" => "lector"], "editar") ? "Permitido\n" : "Denegado\n";
echo permite(["rol" => "administrador"], "editar") ? "Permitido\n" : "Denegado\n";
echo permite(["rol" => "desconocido"], "leer") ? "Permitido\n" : "Denegado\n";
