<?php
declare(strict_types=1);
require_once dirname(__DIR__, 3) . '/proyecto/src/validacion.php';
use function Aprende\{validarTaller, enteroPositivo, escapar, csrfValido};
session_name('leli_lab_crud');
ini_set('session.use_strict_mode', '1');
session_set_cookie_params(['httponly' => true, 'samesite' => 'Lax', 'path' => '/']);
session_start();
header('Cache-Control: no-store');
$_SESSION['csrf'] ??= bin2hex(random_bytes(32));
$_SESSION['talleres'] ??= [];
$_SESSION['siguiente_id'] ??= 1;
function fallar(int $estado, string $mensaje): never {
    http_response_code($estado); header('Content-Type: text/plain; charset=utf-8'); echo $mensaje; exit;
}
$metodo = $_SERVER['REQUEST_METHOD'];
if (!in_array($metodo, ['GET', 'POST'], true)) { header('Allow: GET, POST'); fallar(405, 'Método no permitido'); }
$datos = ['titulo' => '', 'cupo' => '12']; $errores = []; $editar = null;
if ($metodo === 'POST') {
    if (!csrfValido($_SESSION['csrf'], $_POST['csrf'] ?? null)) { fallar(403, 'Token inválido'); }
    $accion = $_POST['accion'] ?? null;
    if (!in_array($accion, ['crear', 'editar', 'eliminar'], true)) { fallar(400, 'Acción inválida'); }
    $id = null;
    if ($accion !== 'crear') {
        $id = enteroPositivo($_POST['id'] ?? null);
        if ($id === null) { fallar(400, 'Identificador inválido'); }
        if (!isset($_SESSION['talleres'][$id])) { fallar(404, 'Taller no encontrado'); }
    }
    if ($accion === 'eliminar') {
        unset($_SESSION['talleres'][$id]);
        header('Location: /', true, 303); exit;
    }
    $resultado = validarTaller($_POST); $errores = $resultado['errores'];
    if ($errores === []) {
        if ($accion === 'crear') { $id = $_SESSION['siguiente_id']++; }
        $_SESSION['talleres'][$id] = ['id' => $id] + $resultado['datos'];
        header('Location: /', true, 303); exit;
    }
    http_response_code(422); $editar = $id;
    $datos = ['titulo' => $resultado['datos']['titulo'], 'cupo' => is_string($_POST['cupo'] ?? null) ? $_POST['cupo'] : ''];
}
if ($metodo === 'GET' && isset($_GET['editar'])) {
    $editar = enteroPositivo($_GET['editar']);
    if ($editar === null) { fallar(400, 'Identificador inválido'); }
    if (!isset($_SESSION['talleres'][$editar])) { fallar(404, 'Taller no encontrado'); }
    $fila = $_SESSION['talleres'][$editar];
    $datos = ['titulo' => $fila['titulo'], 'cupo' => (string) $fila['cupo']];
}
$filtro = $_GET['q'] ?? ''; $pagina = enteroPositivo($_GET['page'] ?? '1');
if (!is_string($filtro) || mb_strlen($filtro, 'UTF-8') > 100 || $pagina === null || $pagina > 100000) { fallar(400, 'Filtro o página inválidos'); }
$filtrados = array_filter($_SESSION['talleres'], fn(array $t): bool => str_contains(mb_strtolower($t['titulo'], 'UTF-8'), mb_strtolower($filtro, 'UTF-8')));
krsort($filtrados); // IDs descendentes, conservando su asociación.
$total = count($filtrados); $filas = array_slice($filtrados, ($pagina - 1) * 10, 10, true);
header('Content-Type: text/html; charset=utf-8');
?>
<!doctype html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>CRUD en sesión</title></head><body><main>
<h1>CRUD en una sesión de práctica</h1><p>No hay cuentas ni base en disco. Los datos se conservan únicamente mientras esta sesión siga disponible; usa información ficticia. No publiques este laboratorio como servicio administrativo.</p>
<h2><?= $editar === null ? 'Crear taller' : 'Editar taller' ?></h2>
<?php if ($errores !== []): ?><ul role="alert"><?php foreach ($errores as $error): ?><li><?= escapar($error) ?></li><?php endforeach; ?></ul><?php endif; ?>
<form method="post" action="/"><input type="hidden" name="csrf" value="<?= escapar($_SESSION['csrf']) ?>"><input type="hidden" name="accion" value="<?= $editar === null ? 'crear' : 'editar' ?>"><?php if ($editar !== null): ?><input type="hidden" name="id" value="<?= $editar ?>"><?php endif; ?>
<label for="titulo">Título</label><input id="titulo" name="titulo" value="<?= escapar($datos['titulo']) ?>" minlength="3" maxlength="100" required><label for="cupo">Cupo</label><input id="cupo" name="cupo" type="number" value="<?= escapar($datos['cupo']) ?>" min="1" max="100" required><button>Guardar taller</button> <a href="/">Cancelar edición</a></form>
<h2>Listado</h2><form method="get" action="/"><label for="q">Buscar</label><input id="q" name="q" value="<?= escapar($filtro) ?>" maxlength="100"><button>Buscar</button></form><p><?= $total ?> talleres · Página <?= $pagina ?></p>
<?php if ($filas === []): ?><p>No hay talleres en esta página.</p><?php else: ?><ul><?php foreach ($filas as $fila): ?><li data-id="<?= $fila['id'] ?>"><strong><?= escapar($fila['titulo']) ?></strong>: <?= $fila['cupo'] ?> plazas <a href="/?editar=<?= $fila['id'] ?>">Editar <?= escapar($fila['titulo']) ?></a>
<details><summary>Eliminar <?= escapar($fila['titulo']) ?></summary><p>Confirma que deseas quitar este taller.</p><form method="post" action="/"><input type="hidden" name="csrf" value="<?= escapar($_SESSION['csrf']) ?>"><input type="hidden" name="accion" value="eliminar"><input type="hidden" name="id" value="<?= $fila['id'] ?>"><button>Confirmar eliminación</button></form></details></li><?php endforeach; ?></ul><?php endif; ?>
<nav aria-label="Páginas"><?php if ($pagina > 1): ?><a href="/?<?= escapar(http_build_query(['q' => $filtro, 'page' => $pagina - 1])) ?>">Anterior</a><?php endif; ?> <?php if ($pagina * 10 < $total): ?><a href="/?<?= escapar(http_build_query(['q' => $filtro, 'page' => $pagina + 1])) ?>">Siguiente</a><?php endif; ?></nav>
</main></body></html>
