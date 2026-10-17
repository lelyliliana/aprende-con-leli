<?php
declare(strict_types=1);

function prepararAlta(array $entrada, callable $guardar): array {
    $titulo = is_string($entrada["titulo"] ?? null) ? trim($entrada["titulo"]) : "";
    if (mb_strlen($titulo, "UTF-8") < 3) {
        return ["ok" => false, "error" => "Título demasiado corto"];
    }
    $id = $guardar($titulo);
    return ["ok" => true, "id" => $id];
}
$guardados = [];
$guardar = function (string $titulo) use (&$guardados): int {
    $guardados[] = $titulo;
    return count($guardados);
};
$fallo = prepararAlta(["titulo" => "ab"], $guardar);
$exito = prepararAlta(["titulo" => " PHP "], $guardar);
echo "Primer resultado: " . ($fallo["ok"] ? "éxito" : "rechazo") . "\n";
echo "Nuevo ID: " . $exito["id"] . "; guardados: " . count($guardados) . "\n";
