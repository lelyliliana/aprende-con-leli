<?php
declare(strict_types=1);

function configurar(array $variables): array {
    $entorno = $variables["APP_ENV"] ?? "local";
    if (!in_array($entorno, ["local", "production"], true)) { throw new InvalidArgumentException("Entorno no reconocido"); }
    $ruta = $variables["APP_DB"] ?? "";
    if (!is_string($ruta)) { throw new InvalidArgumentException("Ruta inválida"); }
    if ($entorno === "production" && trim($ruta) === "") { throw new InvalidArgumentException("Falta APP_DB en producción"); }
    return ["entorno" => $entorno, "base" => $ruta === "" ? "var/talleres.sqlite" : $ruta];
}
echo configurar([])["base"] . "\n";
try { configurar(["APP_ENV" => "production"]); }
catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
