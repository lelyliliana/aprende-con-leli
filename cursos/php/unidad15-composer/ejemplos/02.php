<?php
declare(strict_types=1);

$raiz = '/curso/proyecto';
$clase = 'Aprende\\TallerRepository';
$relativa = substr($clase, strlen('Aprende\\'));
echo $raiz . '/src/' . str_replace('\\', '/', $relativa) . ".php\n";
