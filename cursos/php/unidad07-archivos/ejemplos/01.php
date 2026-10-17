<?php
declare(strict_types=1);

$taller = ["titulo" => "PHP", "cupo" => 12];
$json = json_encode($taller, JSON_THROW_ON_ERROR);
$recuperado = json_decode($json, true, 512, JSON_THROW_ON_ERROR);
echo $json . "\n";
echo $recuperado["titulo"] . "\n";
