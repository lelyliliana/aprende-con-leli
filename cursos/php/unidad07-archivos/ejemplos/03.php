<?php
declare(strict_types=1);

function titulosDesdeJson(string $texto): array {
    $datos = json_decode($texto, false, 512, JSON_THROW_ON_ERROR);
    if (!is_array($datos) || !array_is_list($datos)) {
        throw new InvalidArgumentException("Se esperaba una lista");
    }
    $titulos = [];
    foreach ($datos as $fila) {
        if (!$fila instanceof stdClass || !is_string($fila->titulo ?? null)) {
            throw new InvalidArgumentException("Fila sin título textual");
        }
        $titulos[] = $fila->titulo;
    }
    return $titulos;
}
echo implode(", ", titulosDesdeJson('[{"titulo":"PHP"},{"titulo":"SQL"}]')) . "\n";
try { titulosDesdeJson('[{"cupo":12}]'); }
catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
try { titulosDesdeJson("{}"); }
catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
echo "Vacía: " . count(titulosDesdeJson("[]")) . "\n";
