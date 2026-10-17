<?php
declare(strict_types=1);

$clase = 'Aprende\\Servicio\\Inscripcion';
$relativa = substr($clase, strlen('Aprende\\'));
echo 'src/' . str_replace('\\', '/', $relativa) . ".php\n";
