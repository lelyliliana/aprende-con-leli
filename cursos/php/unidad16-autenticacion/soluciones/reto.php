<?php
declare(strict_types=1);

function puedeAdministrar(array $usuario): bool {
    return isset($usuario["id"]) && ($usuario["rol"] ?? null) === "administrador";
}
echo puedeAdministrar(["id" => 1]) ? "Permitido\n" : "Denegado\n";
