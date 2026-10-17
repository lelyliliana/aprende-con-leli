<?php
declare(strict_types=1);

$token = bin2hex(random_bytes(32));
$copia = $token;
echo strlen($token) . " caracteres\n";
echo hash_equals($token, $copia) ? "Coincide\n" : "No coincide\n";
