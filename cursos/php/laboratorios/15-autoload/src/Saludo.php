<?php
declare(strict_types=1);
namespace AprendeLab;
final class Saludo {
    public function mensaje(string $nombre): string { return "Hola, $nombre"; }
}
