<?php
declare(strict_types=1);
require_once dirname(__DIR__, 3) . '/proyecto/src/validacion.php';
use function Aprende\validarTaller;
header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');
function responder(int $estado, array $cuerpo): never {
    http_response_code($estado); echo json_encode($cuerpo, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE); exit;
}
function errorApi(int $estado, string $codigo): never { responder($estado, ['error' => ['status' => $estado, 'code' => $codigo]]); }
$ruta = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$metodo = $_SERVER['REQUEST_METHOD'];
if ($ruta === '/talleres') {
    if ($metodo !== 'GET') { header('Allow: GET'); errorApi(405, 'metodo_no_permitido'); }
    $filtro = $_GET['q'] ?? '';
    if (!is_string($filtro) || mb_strlen($filtro, 'UTF-8') > 100) { errorApi(400, 'filtro_invalido'); }
    $talleres = [['id' => 1, 'titulo' => 'PHP', 'cupo' => 12], ['id' => 2, 'titulo' => 'HTML', 'cupo' => 8]];
    $seleccion = array_filter($talleres, fn (array $t): bool => str_contains(mb_strtolower($t['titulo'], 'UTF-8'), mb_strtolower($filtro, 'UTF-8')));
    responder(200, ['data' => array_values($seleccion), 'total' => count($seleccion)]);
}
if ($ruta === '/validar') {
    if ($metodo !== 'POST') { header('Allow: POST'); errorApi(405, 'metodo_no_permitido'); }
    $tipo = strtolower(trim(explode(';', $_SERVER['CONTENT_TYPE'] ?? '')[0]));
    if ($tipo !== 'application/json') { errorApi(415, 'se_requiere_json'); }
    $texto = file_get_contents('php://input', false, null, 0, 4097);
    if ($texto === false) { errorApi(400, 'cuerpo_ilegible'); }
    if (strlen($texto) > 4096) { errorApi(413, 'cuerpo_demasiado_grande'); }
    try { $objeto = json_decode($texto, false, 16, JSON_THROW_ON_ERROR); }
    catch (JsonException $e) { errorApi(400, 'json_mal_formado'); }
    if (!$objeto instanceof stdClass || !is_int($objeto->cupo ?? null)) { errorApi(422, 'estructura_invalida'); }
    $resultado = validarTaller(['titulo' => $objeto->titulo ?? null, 'cupo' => (string) $objeto->cupo]);
    if ($resultado['errores'] !== []) { responder(422, ['error' => ['status' => 422, 'code' => 'datos_invalidos', 'fields' => $resultado['errores']]]); }
    responder(200, ['data' => $resultado['datos'], 'persistido' => false]);
}
errorApi(404, 'ruta_no_encontrada');
