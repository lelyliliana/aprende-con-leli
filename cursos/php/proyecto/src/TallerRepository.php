<?php
declare(strict_types=1);

namespace Aprende;

use PDO;
use InvalidArgumentException;

/** Persistencia. El controlador valida datos; SQLite conserva restricciones. */
final class TallerRepository
{
    public function __construct(private PDO $db) {}

    public function crear(string $titulo, int $cupo): int
    {
        $stmt = $this->db->prepare('INSERT INTO talleres (titulo, cupo) VALUES (:titulo, :cupo)');
        $stmt->execute(['titulo' => $titulo, 'cupo' => $cupo]);
        return (int) $this->db->lastInsertId();
    }

    public function buscar(int $id): ?array
    {
        $stmt = $this->db->prepare('SELECT id, titulo, cupo FROM talleres WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $fila = $stmt->fetch();
        return $fila === false ? null : $fila;
    }

    public function listar(string $filtro = '', int $pagina = 1): array
    {
        if ($pagina < 1 || $pagina > 100000) { throw new InvalidArgumentException('Página fuera de rango'); }
        $stmt = $this->db->prepare('SELECT id, titulo, cupo FROM talleres
            WHERE instr(lower(titulo), lower(:filtro)) > 0 ORDER BY id DESC LIMIT 10 OFFSET :inicio');
        // instr busca una subcadena literal: % y _ no actúan como comodines.
        // lower de SQLite básico solo transforma mayúsculas ASCII.
        $stmt->bindValue(':filtro', $filtro, PDO::PARAM_STR);
        $stmt->bindValue(':inicio', ($pagina - 1) * 10, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public function contar(string $filtro = ''): int
    {
        $stmt = $this->db->prepare('SELECT COUNT(*) FROM talleres WHERE instr(lower(titulo), lower(:filtro)) > 0');
        $stmt->execute(['filtro' => $filtro]);
        return (int) $stmt->fetchColumn();
    }

    public function actualizar(int $id, string $titulo, int $cupo): void
    {
        $stmt = $this->db->prepare('UPDATE talleres SET titulo = :titulo, cupo = :cupo WHERE id = :id');
        $stmt->execute(['titulo' => $titulo, 'cupo' => $cupo, 'id' => $id]);
    }

    public function eliminar(int $id): void
    {
        $stmt = $this->db->prepare('DELETE FROM talleres WHERE id = :id');
        $stmt->execute(['id' => $id]);
    }
}
