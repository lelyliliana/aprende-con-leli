<?php
declare(strict_types=1);

$post = ["titulo" => "  PHP  ", "cupo" => "12"];
$titulo = is_string($post["titulo"] ?? null) ? trim($post["titulo"]) : "";
$cupo = is_string($post["cupo"] ?? null) ? filter_var($post["cupo"], FILTER_VALIDATE_INT) : false;
if (mb_strlen($titulo, "UTF-8") >= 3 && $cupo !== false && $cupo >= 1 && $cupo <= 100) {
    echo "$titulo: $cupo plazas\n";
}
