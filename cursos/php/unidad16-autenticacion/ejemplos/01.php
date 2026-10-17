<?php
declare(strict_types=1);

$hash = password_hash("una-frase-larga-de-prueba", PASSWORD_DEFAULT);
echo password_verify("una-frase-larga-de-prueba", $hash) ? "Correcta\n" : "Incorrecta\n";
echo password_verify("otra", $hash) ? "Correcta\n" : "Incorrecta\n";
