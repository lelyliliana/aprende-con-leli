<?php
declare(strict_types=1);

function cambiarNota(array $sesion, mixed $tokenRecibido, string $nota): array {
    $esperado = $sesion["csrf"] ?? null;
    if (!is_string($esperado) || $esperado === "" || !is_string($tokenRecibido) || !hash_equals($esperado, $tokenRecibido)) {
        throw new InvalidArgumentException("Token inválido");
    }
    $sesion["nota"] = $nota;
    return $sesion;
}
$sesion = ["csrf" => "token-fijo-solo-para-prueba", "nota" => "Original"];
try { $sesion = cambiarNota($sesion, "otro", "Alterada"); }
catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
echo "Tras rechazo: " . $sesion["nota"] . "\n";
$sesion = cambiarNota($sesion, $sesion["csrf"], "Revisada");
echo "Tras aceptación: " . $sesion["nota"] . "\n";
