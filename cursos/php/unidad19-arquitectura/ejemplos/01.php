<?php
declare(strict_types=1);

function erroresTitulo(mixed $titulo): array {
    if (!is_string($titulo) || mb_strlen(trim($titulo), "UTF-8") < 3) {
        return ["titulo" => "Usa al menos 3 caracteres"];
    }
    return [];
}
echo count(erroresTitulo("PHP")) . " errores\n";
echo count(erroresTitulo([])) . " error\n";
