<?php
declare(strict_types=1);

function tituloValido(mixed $valor): bool {
    if (!is_string($valor)) { return false; }
    $longitud = mb_strlen(trim($valor), "UTF-8");
    return $longitud >= 3 && $longitud <= 100;
}
echo tituloValido(str_repeat("a", 101)) ? "Válido\n" : "Inválido\n";
