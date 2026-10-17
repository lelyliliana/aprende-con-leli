<?php
declare(strict_types=1);

$titulo = "<script>alert(1)</script>";
$seguro = htmlspecialchars($titulo, ENT_QUOTES | ENT_SUBSTITUTE, "UTF-8");
echo "<h1>$seguro</h1>\n";
