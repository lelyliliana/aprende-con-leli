<?php
declare(strict_types=1);

namespace Aprende;

/** Devuelve datos normalizados y errores; nunca confía en los tipos del formulario. */
function validarTaller(array $entrada): array
{
    $titulo = is_string($entrada['titulo'] ?? null) ? trim($entrada['titulo']) : '';
    $textoCupo = $entrada['cupo'] ?? null;
    $cupo = is_string($textoCupo) ? filter_var($textoCupo, FILTER_VALIDATE_INT) : false;
    $errores = [];
    $longitud = mb_strlen($titulo, 'UTF-8');
    if ($longitud < 3 || $longitud > 100) {
        $errores['titulo'] = 'Escribe un título de 3 a 100 caracteres.';
    }
    if ($cupo === false || $cupo < 1 || $cupo > 100) {
        $errores['cupo'] = 'Escribe un cupo entero entre 1 y 100.';
    }
    return ['datos' => ['titulo' => $titulo, 'cupo' => $cupo], 'errores' => $errores];
}

function enteroPositivo(mixed $valor): ?int
{
    if (!is_string($valor)) { return null; }
    $n = filter_var($valor, FILTER_VALIDATE_INT);
    return $n !== false && $n > 0 ? $n : null;
}

function escapar(string $texto): string
{
    return htmlspecialchars($texto, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

function csrfValido(mixed $esperado, mixed $recibido): bool
{
    return is_string($esperado) && $esperado !== '' && is_string($recibido)
        && hash_equals($esperado, $recibido);
}
