<?php
declare(strict_types=1);

function saludar(string $nombre = "estudiante"): string {
    return "Hola, $nombre";
}
echo saludar() . "\n";
echo saludar("Leli") . "\n";
