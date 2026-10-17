<?php
declare(strict_types=1);

interface Contador { public function total(): int; }
final class ContadorLista implements Contador {
    public function __construct(private array $elementos) {}
    public function total(): int { return count($this->elementos); }
}
echo (new ContadorLista(["PHP", "Web"]))->total() . "\n";
