<?php
declare(strict_types=1);

$entrega = ["php" => ">=8.4", "extensiones" => ["pdo_sqlite", "mbstring"], "raiz_web" => "proyecto/public"];
echo "PHP " . $entrega["php"] . "\n";
echo "Raíz: " . $entrega["raiz_web"] . "\n";
