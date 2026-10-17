<?php
declare(strict_types=1);

function revisar(array $entrada): array {
    $titulo = is_string($entrada["titulo"] ?? null) ? trim($entrada["titulo"]) : "";
    $cupoTexto = $entrada["cupo"] ?? null;
    $cupo = is_string($cupoTexto) ? filter_var($cupoTexto, FILTER_VALIDATE_INT) : false;
    $errores = [];
    if (mb_strlen($titulo, "UTF-8") < 3 || mb_strlen($titulo, "UTF-8") > 100) { $errores["titulo"] = "Longitud inválida"; }
    if ($cupo === false || $cupo < 1 || $cupo > 100) { $errores["cupo"] = "Cupo fuera de rango"; }
    return ["datos" => ["titulo" => $titulo, "cupo" => $cupo], "errores" => $errores];
}
foreach ([["titulo" => " PHP ", "cupo" => "1"], ["titulo" => "ab", "cupo" => []]] as $entrada) {
    $resultado = revisar($entrada);
    echo "Título: " . $resultado["datos"]["titulo"] . "; errores: " . count($resultado["errores"]) . "\n";
}
