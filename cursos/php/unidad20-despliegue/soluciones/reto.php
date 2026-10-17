<?php
declare(strict_types=1);

function exigirRuta(string $ruta): string {
    if (trim($ruta) === "") { throw new InvalidArgumentException("Ruta vacía"); }
    return $ruta;
}
try { exigirRuta(" "); } catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
