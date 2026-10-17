<?php
declare(strict_types=1);

// Carga mínima sin paquetes. Composer es una alternativa opcional de la unidad 15.
require_once __DIR__ . '/validacion.php';
require_once __DIR__ . '/TallerRepository.php';

function conectar(): PDO
{
    $ruta = getenv('APP_DB');
    if ($ruta === false || $ruta === '') { $ruta = dirname(__DIR__) . '/var/talleres.sqlite'; }
    return new PDO('sqlite:' . $ruta, null, null, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
}
