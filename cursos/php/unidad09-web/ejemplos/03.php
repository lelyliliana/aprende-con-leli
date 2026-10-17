<?php
declare(strict_types=1);

$titulos = ["PHP & HTML", "<b>SQL</b>"];
echo "<ul>\n";
foreach ($titulos as $titulo) {
    $texto = htmlspecialchars($titulo, ENT_QUOTES | ENT_SUBSTITUTE, "UTF-8");
    echo "  <li>$texto</li>\n";
}
echo "</ul>\n";
