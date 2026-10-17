<?php
declare(strict_types=1);

$total = 0;
for ($n = 1; $n <= 6; $n++) {
    if ($n % 2 === 0) { $total += $n; }
}
echo "$total\n";
