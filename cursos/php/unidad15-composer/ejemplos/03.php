<?php
declare(strict_types=1);

$llamadas = 0;
spl_autoload_register(function (string $nombre) use (&$llamadas): void {
    if ($nombre === "EtiquetaCarga") {
        $llamadas++;
        // La clase se define al alcanzar este bloque; no se usa eval ni una ruta externa.
        class EtiquetaCarga {
            public function texto(): string { return "Clase disponible"; }
        }
    }
});
echo (new EtiquetaCarga())->texto() . "\n";
echo (new EtiquetaCarga())->texto() . "\n";
echo "Cargas: $llamadas\n";
