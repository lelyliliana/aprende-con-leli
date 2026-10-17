<?php
declare(strict_types=1);
require_once __DIR__ . '/autoload.php';
use AprendeLab\{Saludo, Informe};
echo (new Informe(new Saludo()))->linea() . "\n";
