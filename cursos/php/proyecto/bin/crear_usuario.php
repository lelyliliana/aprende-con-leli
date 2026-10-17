<?php
declare(strict_types=1);
require_once dirname(__DIR__) . '/src/bootstrap.php';
$nombre = $argv[1] ?? '';
if (!preg_match('/\A[a-zA-Z0-9_-]{3,40}\z/', $nombre)) {
    fwrite(STDERR, "Uso: php proyecto/bin/crear_usuario.php nombre (3–40 letras ASCII, números, _ o -)\n"); exit(1);
}
fwrite(STDOUT, "Escribe una contraseña de al menos 12 caracteres. La terminal mostrará lo escrito: usa una clave exclusiva de práctica.\nContraseña: ");
$linea = fgets(STDIN);
$clave = $linea === false ? '' : rtrim($linea, "\r\n");
if (mb_strlen($clave, 'UTF-8') < 12 || strlen($clave) > 72) {
    fwrite(STDERR, "Usa al menos 12 caracteres y como máximo 72 bytes.\n"); exit(1);
}
$db = conectar();
$stmt = $db->prepare('INSERT INTO usuarios (nombre, hash) VALUES (:nombre, :hash)');
try {
    $stmt->execute(['nombre' => $nombre, 'hash' => password_hash($clave, PASSWORD_DEFAULT)]);
} catch (PDOException $e) {
    fwrite(STDERR, "No se pudo crear la cuenta. Comprueba que la base esté inicializada y el nombre no exista.\n"); exit(1);
}
echo "Cuenta administradora creada.\n";
