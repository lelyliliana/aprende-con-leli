<?php
declare(strict_types=1);
require_once dirname(__DIR__) . '/src/bootstrap.php';
use Aprende\TallerRepository;
use function Aprende\{validarTaller, enteroPositivo, escapar, csrfValido};
$comprobaciones = 0;
function verificar(bool $condicion, string $mensaje): void {
    global $comprobaciones;
    if (!$condicion) { throw new RuntimeException($mensaje); }
    $comprobaciones++;
}
foreach ([['PHP', '1'], ['PHP', '100'], [str_repeat('ó', 100), '12']] as [$titulo, $cupo]) {
    verificar(validarTaller(compact('titulo','cupo'))['errores'] === [], 'Se rechazó un taller válido');
}
foreach (['', 'ab', str_repeat('a', 101), [], null] as $titulo) {
    verificar(isset(validarTaller(['titulo' => $titulo, 'cupo' => '12'])['errores']['titulo']), 'Se aceptó título inválido');
}
foreach (['0', '-1', '101', '1.2', 'abc', [], null] as $cupo) {
    verificar(isset(validarTaller(['titulo' => 'PHP', 'cupo' => $cupo])['errores']['cupo']), 'Se aceptó cupo inválido');
}
verificar(validarTaller(['titulo' => ' PHP ', 'cupo' => '12'])['datos'] === ['titulo' => 'PHP', 'cupo' => 12], 'No normaliza');
verificar(enteroPositivo('1') === 1 && enteroPositivo('0') === null && enteroPositivo([]) === null, 'ID inválido');
verificar(escapar('<b>"&') === '&lt;b&gt;&quot;&amp;', 'Escape HTML incorrecto');
verificar(csrfValido('abc', 'abc'), 'Token correcto rechazado');
foreach ([null, [], '', 'otro'] as $token) { verificar(!csrfValido('abc', $token), 'Token inválido aceptado'); }
verificar(!csrfValido('', ''), 'Tokens vacíos aceptados');
$db = new PDO('sqlite::memory:', null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]);
$db->exec(file_get_contents(dirname(__DIR__) . '/schema.sql'));
$repo = new TallerRepository($db);
verificar($repo->listar() === [] && $repo->contar() === 0, 'Base inicialmente no vacía');
$id = $repo->crear("PHP de Leli's", 12);
verificar($id > 0 && $repo->buscar($id)['titulo'] === "PHP de Leli's", 'Crear o buscar con comilla falla');
verificar($repo->contar("' OR 1=1 --") === 0, 'Inyección SQL en búsqueda');
verificar($repo->contar('php') === 1, 'Búsqueda ASCII sin distinción falla');
$porcentaje = $repo->crear('100% PHP', 20);
verificar($repo->contar('%') === 1, 'El filtro debe ser literal');
$repo->actualizar($id, 'PHP web', 30);
verificar($repo->buscar($id)['cupo'] === 30, 'Editar falla');
verificar($repo->buscar(99999) === null, 'Fila inexistente encontrada');
$repo->eliminar($porcentaje);
verificar($repo->buscar($porcentaje) === null && $repo->contar() === 1, 'Eliminar afecta a otra fila');
for ($i = 0; $i < 11; $i++) { $repo->crear('Taller ' . $i, 10); }
verificar(count($repo->listar('', 1)) === 10 && count($repo->listar('', 2)) === 2, 'Paginación incorrecta');
$primera = array_column($repo->listar('', 1), 'id');
$segunda = array_column($repo->listar('', 2), 'id');
verificar(array_intersect($primera, $segunda) === [], 'Repite filas entre páginas');
foreach ([0, -1, 100001] as $pagina) {
    $rechazo = false;
    try { $repo->listar('', $pagina); } catch (InvalidArgumentException $e) { $rechazo = true; }
    verificar($rechazo, 'Página inválida aceptada');
}
foreach ([['ab', 12], ['PHP', 0], ['PHP', 101]] as [$titulo, $cupo]) {
    $rechazo = false;
    try { $repo->crear($titulo, $cupo); } catch (PDOException $e) { $rechazo = true; }
    verificar($rechazo, 'Restricción SQL no aplicada');
}
$antes = $repo->contar();
$db->beginTransaction(); $repo->crear('Temporal', 1); $db->rollBack();
verificar($repo->contar() === $antes, 'Rollback no revierte');
$clave = 'frase-de-prueba-larga'; $hash = password_hash($clave, PASSWORD_DEFAULT);
verificar(password_verify($clave, $hash) && !password_verify('otra', $hash), 'Verificación de contraseña incorrecta');
echo "$comprobaciones comprobaciones de integración correctas.\n";
