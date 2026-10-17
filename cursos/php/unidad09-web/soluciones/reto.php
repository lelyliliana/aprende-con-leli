<?php
declare(strict_types=1);

$nombre = "Ana & Luis";
echo "<p>" . htmlspecialchars($nombre, ENT_QUOTES | ENT_SUBSTITUTE, "UTF-8") . "</p>\n";
