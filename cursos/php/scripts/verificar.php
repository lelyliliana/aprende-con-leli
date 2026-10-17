<?php
declare(strict_types=1);
$raiz = dirname(__DIR__);
if (PHP_VERSION_ID < 80400) { fwrite(STDERR, "Se requiere PHP 8.4 o posterior.\n"); exit(1); }
foreach (['pdo_sqlite', 'mbstring', 'session'] as $extension) {
    if (!extension_loaded($extension)) { fwrite(STDERR, "Falta extensión: $extension. Consulta docs/ERRORES.md\n"); exit(1); }
}
function ejecutar(array $comando): array {
    $pipes = [];
    $p = proc_open($comando, [0 => ['pipe','r'], 1 => ['pipe','w'], 2 => ['pipe','w']], $pipes);
    if (!is_resource($p)) { throw new RuntimeException('No se pudo iniciar PHP'); }
    fclose($pipes[0]);
    $salida = stream_get_contents($pipes[1]); $error = stream_get_contents($pipes[2]);
    fclose($pipes[1]); fclose($pipes[2]);
    return [proc_close($p), $salida, $error];
}
$archivos = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($raiz, FilesystemIterator::SKIP_DOTS));
$revisados = 0;
foreach ($archivos as $archivo) {
    if ($archivo->getExtension() !== 'php' || str_contains($archivo->getPathname(), DIRECTORY_SEPARATOR . 'vendor' . DIRECTORY_SEPARATOR)) { continue; }
    [$codigo, $salida, $error] = ejecutar([PHP_BINARY, '-l', $archivo->getPathname()]);
    if ($codigo !== 0) { throw new RuntimeException($salida . $error); }
    $revisados++;
}
$casos = json_decode(file_get_contents(__DIR__ . '/ejemplos.json'), true, 512, JSON_THROW_ON_ERROR);
$casos = array_merge($casos, json_decode(file_get_contents(__DIR__ . '/soluciones.json'), true, 512, JSON_THROW_ON_ERROR));
$casos = array_merge($casos, json_decode(file_get_contents(__DIR__ . '/laboratorios.json'), true, 512, JSON_THROW_ON_ERROR));
foreach ($casos as $caso) {
    [$codigo, $salida, $error] = ejecutar([PHP_BINARY, '-d', 'display_errors=stderr', '-d', 'error_reporting=-1', $raiz . '/' . $caso['file'], ...($caso['args'] ?? [])]);
    $esperada = file_get_contents($raiz . '/' . $caso['expected']);
    // Normalizar solamente finales de línea de Windows.
    if ($codigo !== ($caso['exit'] ?? 0) || $error !== '' || str_replace("\r\n", "\n", $salida) !== str_replace("\r\n", "\n", $esperada)) {
        throw new RuntimeException($caso['file'] . "\nEsperada: " . $esperada . "\nObtenida: " . $salida . "\n" . $error);
    }
}
echo "$revisados archivos PHP sin errores de sintaxis; " . count($casos) . " ejecuciones con salida y código de terminación esperados.\n";
