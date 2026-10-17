<?php
declare(strict_types=1);
require_once dirname(__DIR__, 3) . '/proyecto/src/validacion.php';
use function Aprende\{validarTaller, escapar};
$metodo = $_SERVER['REQUEST_METHOD'];
if (!in_array($metodo, ['GET', 'POST'], true)) {
    header('Allow: GET, POST'); http_response_code(405); echo 'Método no permitido'; exit;
}
$datos = ['titulo' => '', 'cupo' => '12'];
$errores = [];
$valido = false;
if ($metodo === 'POST') {
    $resultado = validarTaller($_POST);
    $errores = $resultado['errores'];
    $datos = ['titulo' => $resultado['datos']['titulo'], 'cupo' => is_string($_POST['cupo'] ?? null) ? $_POST['cupo'] : ''];
    $valido = $errores === [];
    if (!$valido) { http_response_code(422); }
}
header('Content-Type: text/html; charset=utf-8');
?>
<!doctype html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Validar sin guardar</title></head><body><main>
<h1>Validar un taller</h1><p>Este laboratorio no guarda datos ni crea una cuenta. Solo devuelve el resultado de la validación.</p>
<?php if ($valido): ?><p role="status">Datos válidos: <?= escapar($datos['titulo']) ?>, <?= escapar($datos['cupo']) ?> plazas. No se guardó información.</p><?php endif; ?>
<?php if ($errores !== []): ?><div role="alert"><p>Corrige los campos indicados.</p></div><?php endif; ?>
<form method="post" action="/">
<label for="titulo">Título (3–100 caracteres)</label><input id="titulo" name="titulo" value="<?= escapar($datos['titulo']) ?>" required minlength="3" maxlength="100" <?= isset($errores['titulo']) ? 'aria-invalid="true" aria-describedby="error-titulo"' : '' ?>>
<?php if (isset($errores['titulo'])): ?><p id="error-titulo"><?= escapar($errores['titulo']) ?></p><?php endif; ?>
<label for="cupo">Cupo (1–100)</label><input id="cupo" name="cupo" type="number" value="<?= escapar($datos['cupo']) ?>" required min="1" max="100" <?= isset($errores['cupo']) ? 'aria-invalid="true" aria-describedby="error-cupo"' : '' ?>>
<?php if (isset($errores['cupo'])): ?><p id="error-cupo"><?= escapar($errores['cupo']) ?></p><?php endif; ?>
<button>Validar</button></form></main></body></html>
