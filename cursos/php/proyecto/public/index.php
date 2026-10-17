<?php
declare(strict_types=1);

use Aprende\TallerRepository;
use function Aprende\{validarTaller, enteroPositivo, escapar, csrfValido};
require_once dirname(__DIR__) . '/src/bootstrap.php';

$produccion = getenv('APP_ENV') === 'production';
error_reporting(E_ALL);
ini_set('display_errors', $produccion ? '0' : '1');
ini_set('session.use_strict_mode', '1');
ini_set('session.use_only_cookies', '1');
session_name('leli_talleres');
session_set_cookie_params(['httponly' => true, 'samesite' => 'Lax', 'secure' => getenv('APP_HTTPS') === '1', 'path' => '/']);
session_start();
header('Cache-Control: no-store');
header('X-Content-Type-Options: nosniff');
header("Content-Security-Policy: default-src 'self'; style-src 'self'; form-action 'self'; frame-ancestors 'none'; base-uri 'none'");
$_SESSION['csrf'] ??= bin2hex(random_bytes(32));
$csrf = $_SESSION['csrf'];
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$api = $path === '/api/talleres';

function responderError(int $estado, string $mensaje, bool $api): never
{
    http_response_code($estado);
    if ($api) {
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode(['error' => ['status' => $estado, 'message' => $mensaje]], JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE);
    } else {
        header('Content-Type: text/html; charset=utf-8');
        echo '<!doctype html><html lang="es"><meta charset="UTF-8"><title>Error</title><h1>' . $estado . '</h1><p>' . escapar($mensaje) . '</p><a href="/">Volver</a></html>';
    }
    exit;
}
function volver(): never { header('Location: /', true, 303); exit; }

try {
    if (!in_array($path, ['/', '/index.php', '/api/talleres'], true)) { responderError(404, 'Página no encontrada.', false); }
    $metodo = $_SERVER['REQUEST_METHOD'];
    if (!in_array($metodo, $api ? ['GET'] : ['GET', 'POST'], true)) {
        header('Allow: ' . ($api ? 'GET' : 'GET, POST'));
        responderError(405, 'Método no permitido.', $api);
    }
    $db = conectar();
    $repo = new TallerRepository($db);
    // Solo aceptamos IDs de sesión que todavía correspondan a una cuenta existente.
    $usuario = null;
    if (isset($_SESSION['usuario_id'])) {
        $stmt = $db->prepare('SELECT id, nombre FROM usuarios WHERE id = :id');
        $stmt->execute(['id' => $_SESSION['usuario_id']]);
        $usuario = $stmt->fetch() ?: null;
    }
    $errores = [];
    $datos = ['titulo' => '', 'cupo' => '12'];
    $editar = null;
    $errorLogin = '';
    if ($metodo === 'POST') {
        if (!csrfValido($csrf, $_POST['csrf'] ?? null)) { responderError(403, 'El formulario venció o el token no es válido. Recarga la página.', false); }
        $accion = $_POST['accion'] ?? null;
        if (!is_string($accion)) { responderError(400, 'Acción inválida.', false); }
        if ($accion === 'entrar') {
            $nombre = is_string($_POST['nombre'] ?? null) ? $_POST['nombre'] : '';
            $clave = is_string($_POST['clave'] ?? null) ? $_POST['clave'] : '';
            $stmt = $db->prepare('SELECT id, hash FROM usuarios WHERE nombre = :nombre');
            $stmt->execute(['nombre' => $nombre]);
            $fila = $stmt->fetch();
            // Hash ficticio para ejecutar también una verificación si el nombre no existe.
            $hash = $fila === false ? '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.' : $fila['hash'];
            $verificada = strlen($clave) <= 72 && password_verify($clave, $hash);
            if ($verificada && $fila !== false) {
                session_regenerate_id(true);
                $_SESSION['usuario_id'] = (int) $fila['id'];
                $_SESSION['csrf'] = bin2hex(random_bytes(32));
                if (password_needs_rehash($fila['hash'], PASSWORD_DEFAULT)) {
                    $stmt = $db->prepare('UPDATE usuarios SET hash = :hash WHERE id = :id');
                    $stmt->execute(['hash' => password_hash($clave, PASSWORD_DEFAULT), 'id' => $fila['id']]);
                }
                volver();
            }
            http_response_code(401);
            $errorLogin = 'Nombre o contraseña incorrectos.';
        } else {
            if ($usuario === null) { responderError(401, 'Inicia sesión para modificar talleres.', false); }
            if ($accion === 'salir') {
                $_SESSION = ['csrf' => bin2hex(random_bytes(32))];
                session_regenerate_id(true);
                volver();
            }
            if (!in_array($accion, ['crear', 'editar', 'eliminar'], true)) { responderError(400, 'Acción desconocida.', false); }
            $id = null;
            if ($accion !== 'crear') {
                $id = enteroPositivo($_POST['id'] ?? null);
                if ($id === null) { responderError(400, 'Identificador inválido.', false); }
                if ($repo->buscar($id) === null) { responderError(404, 'Taller no encontrado.', false); }
            }
            if ($accion === 'eliminar') {
                $repo->eliminar($id);
                $_SESSION['flash'] = 'Taller eliminado.';
                volver();
            }
            $validacion = validarTaller($_POST);
            $errores = $validacion['errores'];
            // Mantener texto de entrada para corregirlo sin perder el contenido.
            $datos = ['titulo' => $validacion['datos']['titulo'], 'cupo' => is_string($_POST['cupo'] ?? null) ? $_POST['cupo'] : ''];
            if ($errores === []) {
                if ($accion === 'crear') { $repo->crear($datos['titulo'], $validacion['datos']['cupo']); }
                else { $repo->actualizar($id, $datos['titulo'], $validacion['datos']['cupo']); }
                $_SESSION['flash'] = 'Taller guardado.';
                volver();
            }
            http_response_code(422);
            $editar = $id;
        }
    }
    if ($api && $usuario === null) { responderError(401, 'Inicia sesión para consultar la API.', true); }
    $filtro = $_GET['q'] ?? '';
    if (!is_string($filtro) || mb_strlen($filtro, 'UTF-8') > 100) { responderError(400, 'Filtro inválido.', $api); }
    $pagina = enteroPositivo($_GET['page'] ?? '1');
    if ($pagina === null || $pagina > 100000) { responderError(400, 'Página inválida.', $api); }
    if ($metodo === 'GET' && isset($_GET['editar'])) {
        if ($usuario === null) { responderError(401, 'Inicia sesión para editar.', false); }
        $editar = enteroPositivo($_GET['editar']);
        if ($editar === null) { responderError(400, 'Identificador inválido.', false); }
        $taller = $repo->buscar($editar);
        if ($taller === null) { responderError(404, 'Taller no encontrado.', false); }
        $datos = ['titulo' => $taller['titulo'], 'cupo' => (string) $taller['cupo']];
    }
    $filas = $usuario === null ? [] : $repo->listar($filtro, $pagina);
    $total = $usuario === null ? 0 : $repo->contar($filtro);
    if ($api) {
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode(['data' => $filas, 'page' => $pagina, 'per_page' => 10, 'total' => $total], JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE);
        exit;
    }
    $flash = $_SESSION['flash'] ?? '';
    unset($_SESSION['flash']);
} catch (Throwable $e) {
    error_log((string) $e);
    responderError(500, 'No se pudo completar la operación. Revisa la configuración y el registro del servidor.', $api);
}
header('Content-Type: text/html; charset=utf-8');
?>
<!doctype html>
<html lang="es">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Gestor de talleres · Aprende con Leli</title><link rel="stylesheet" href="/styles.css"></head>
<body><main>
<p class="marca">Aprende con Leli · Proyecto PHP</p>
<h1>Gestor de talleres</h1>
<p>Organiza títulos y cupos. Aplicación educativa de uso local.</p>
<?php if ($usuario === null): ?>
<section><h2>Acceso de administración</h2>
<p>Crea primero tu cuenta desde la terminal, como indica la guía del proyecto.</p>
<?php if ($errorLogin !== ''): ?><p role="alert"><?= escapar($errorLogin) ?></p><?php endif; ?>
<form method="post" action="/">
<input type="hidden" name="csrf" value="<?= escapar($csrf) ?>"><input type="hidden" name="accion" value="entrar">
<label for="nombre">Nombre</label><input id="nombre" name="nombre" autocomplete="username" required maxlength="40">
<label for="clave">Contraseña</label><input id="clave" name="clave" type="password" autocomplete="current-password" required>
<button>Iniciar sesión</button></form></section>
<?php else: ?>
<div class="barra"><p>Sesión: <?= escapar($usuario['nombre']) ?></p><form method="post" action="/"><input type="hidden" name="csrf" value="<?= escapar($csrf) ?>"><input type="hidden" name="accion" value="salir"><button class="secundario">Cerrar sesión</button></form></div>
<?php if ($flash !== ''): ?><p role="status"><?= escapar($flash) ?></p><?php endif; ?>
<section><h2><?= $editar === null ? 'Crear taller' : 'Editar taller' ?></h2>
<?php if ($errores !== []): ?><div role="alert"><p>Revisa los campos:</p><ul><?php foreach ($errores as $mensaje): ?><li><?= escapar($mensaje) ?></li><?php endforeach; ?></ul></div><?php endif; ?>
<form method="post" action="/">
<input type="hidden" name="csrf" value="<?= escapar($csrf) ?>"><input type="hidden" name="accion" value="<?= $editar === null ? 'crear' : 'editar' ?>">
<?php if ($editar !== null): ?><input type="hidden" name="id" value="<?= $editar ?>"><?php endif; ?>
<label for="titulo">Título (3–100 caracteres)</label><input id="titulo" name="titulo" value="<?= escapar($datos['titulo']) ?>" minlength="3" maxlength="100" required <?= isset($errores['titulo']) ? 'aria-invalid="true" aria-describedby="error-titulo"' : '' ?>>
<?php if (isset($errores['titulo'])): ?><p id="error-titulo"><?= escapar($errores['titulo']) ?></p><?php endif; ?>
<label for="cupo">Cupo (1–100)</label><input id="cupo" name="cupo" type="number" value="<?= escapar($datos['cupo']) ?>" min="1" max="100" required <?= isset($errores['cupo']) ? 'aria-invalid="true" aria-describedby="error-cupo"' : '' ?>>
<?php if (isset($errores['cupo'])): ?><p id="error-cupo"><?= escapar($errores['cupo']) ?></p><?php endif; ?>
<button>Guardar taller</button><?php if ($editar !== null): ?> <a href="/">Cancelar edición</a><?php endif; ?></form></section>
<section><h2>Talleres registrados</h2>
<form method="get" action="/" class="busqueda"><label for="q">Buscar por título</label><input id="q" name="q" value="<?= escapar($filtro) ?>" maxlength="100"><button>Buscar</button><a href="/">Ver todos</a></form>
<p><?= $total ?> talleres · Página <?= $pagina ?></p>
<?php if ($filas === []): ?><p>No hay talleres en esta página. Crea uno o cambia la búsqueda.</p><?php else: ?>
<div class="tabla"><table><caption>Talleres y acciones de administración</caption><thead><tr><th scope="col">Título</th><th scope="col">Cupo</th><th scope="col">Acciones</th></tr></thead><tbody>
<?php foreach ($filas as $fila): ?><tr><td><?= escapar($fila['titulo']) ?></td><td><?= (int) $fila['cupo'] ?></td><td>
<a href="/?editar=<?= (int) $fila['id'] ?>">Editar <span class="sr-only"><?= escapar($fila['titulo']) ?></span></a>
<details><summary>Eliminar taller</summary><p>Eliminarás <?= escapar($fila['titulo']) ?>. Esta acción no se puede deshacer desde la aplicación.</p><form method="post" action="/"><input type="hidden" name="csrf" value="<?= escapar($csrf) ?>"><input type="hidden" name="accion" value="eliminar"><input type="hidden" name="id" value="<?= (int) $fila['id'] ?>"><button class="peligro">Confirmar eliminación</button></form></details>
</td></tr><?php endforeach; ?></tbody></table></div><?php endif; ?>
<nav aria-label="Páginas de talleres"><?php if ($pagina > 1): ?><a href="/?<?= escapar(http_build_query(['q' => $filtro, 'page' => $pagina - 1])) ?>">Anterior</a><?php endif; ?> <?php if ($pagina * 10 < $total): ?><a href="/?<?= escapar(http_build_query(['q' => $filtro, 'page' => $pagina + 1])) ?>">Siguiente</a><?php endif; ?></nav>
<p><a href="/api/talleres">Consultar API JSON</a></p></section>
<?php endif; ?>
<footer><p>Proyecto educativo de Leli Liliana Díaz Izquierdo. Revisa CONSTRUCCION.md para estudiar el flujo y sus límites.</p></footer>
</main></body></html>
