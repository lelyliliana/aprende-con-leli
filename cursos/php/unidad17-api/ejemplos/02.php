<?php
declare(strict_types=1);

$dato = json_decode("[1,2]", false, 512, JSON_THROW_ON_ERROR);
if (!$dato instanceof stdClass) {
    echo "422: se esperaba un objeto\n";
}
