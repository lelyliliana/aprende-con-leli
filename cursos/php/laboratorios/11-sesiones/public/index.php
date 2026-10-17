<?php
declare(strict_types=1);
require_once dirname(__DIR__, 3) . '/proyecto/src/validacion.php';
use function Aprende\{escapar, csrfValido};
ini_set('session.use_strict_mode', '1');
session_name('leli_lab_notas');
session_set_cookie_params(['httponly' => true, 'samesite' => 'Lax', 'path' => '/']);
session_start();
header('Cache-Control: no-store');
$_SESSION['csrf'] ??= bin2hex(random_bytes(32));
$metodo = $_SERVER['REQUEST_METHOD'];
if (!in_array($metodo, ['GET', 'POST'], true)) {
    header('Allow: GET, POST'); http_response_code(405); echo 'Método no permitido'; exit;
}
$error = '';
$entrada = $_SESSION['nota'] ?? '';
if ($metodo === 'POST') {
    if (!csrfValido($_SESSION['csrf'], $_POST['csrf'] ?? null)) {
        http_response_code(403); echo 'Token inválido; la nota anterior se conserva.'; exit;
    }
    $entrada = is_string($_POST['nota'] ?? null) ? trim($_POST['nota']) : '';
    if ($entrada === '' || mb_strlen($entrada, 'UTF-8') > 120) {
        http_response_code(422); $error = 'Escribe una nota de 1 a 120 caracteres.';
    } else {
        $_SESSION['nota'] = $entrada;
        $_SESSION['flash'] = 'Nota guardada en esta sesión.';
        header('Location: /', true, 303); exit;
    }
}
$flash = $_SESSION['flash'] ?? '';
unset($_SESSION['flash']);
header('Content-Type: text/html; charset=utf-8');
?>
<!doctype html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Nota de sesión</title></head><body><main>
<h1>Una nota por sesión</h1><p>Usa solo texto ficticio de práctica. Otra pestaña normal puede compartir la sesión; un perfil separado no debería heredarla.</p>
<?php if ($flash !== ''): ?><p role="status"><?= escapar($flash) ?></p><?php endif; ?>
<?php if ($error !== ''): ?><p role="alert" id="error-nota"><?= escapar($error) ?></p><?php endif; ?>
<p>Nota conservada: <strong><?= escapar($_SESSION['nota'] ?? 'Sin nota') ?></strong></p>
<form method="post" action="/"><input type="hidden" name="csrf" value="<?= escapar($_SESSION['csrf']) ?>"><label for="nota">Nota</label><input id="nota" name="nota" value="<?= escapar($entrada) ?>" required maxlength="120" <?= $error !== '' ? 'aria-invalid="true" aria-describedby="error-nota"' : '' ?>><button>Guardar en sesión</button></form>
</main></body></html>
