<?php
declare(strict_types=1);

try {
    json_decode("{mal}", true, 512, JSON_THROW_ON_ERROR);
} catch (JsonException $error) {
    echo "JSON inválido\n";
} finally {
    echo "Operación terminada\n";
}
