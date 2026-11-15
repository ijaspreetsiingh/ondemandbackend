<?php
/* dev-only router: static files + /api proxy to live server (bypasses CORS for local testing) */
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$public = __DIR__;

if ($uri !== '/' && file_exists($public . $uri) && !is_dir($public . $uri)) {
    return false; // serve static file
}

if (preg_match('#^/api/#', $uri)) {
    $target = 'http://3.105.34.66' . $_SERVER['REQUEST_URI'];
    $ch = curl_init($target);
    $method = $_SERVER['REQUEST_METHOD'];
    $headers = [];
    foreach (getallheaders() as $k => $v) {
        if (strcasecmp($k, 'host') === 0) continue;
        $headers[] = "$k: $v";
    }
    curl_setopt_array($ch, [
        CURLOPT_CUSTOMREQUEST => $method,
        CURLOPT_HTTPHEADER => $headers,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HEADER => true,
        CURLOPT_TIMEOUT => 60,
    ]);
    if (in_array($method, ['POST', 'PUT', 'PATCH', 'DELETE'])) {
        curl_setopt($ch, CURLOPT_POSTFIELDS, file_get_contents('php://input'));
    }
    $resp = curl_exec($ch);
    if ($resp === false) {
        http_response_code(502);
        header('Content-Type: application/json');
        echo json_encode(['response_code' => 'proxy_error', 'message' => 'Upstream unreachable: ' . curl_error($ch)]);
        exit;
    }
    $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $hsize = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
    curl_close($ch);
    http_response_code($status ?: 200);
    foreach (explode("\r\n", substr($resp, 0, $hsize)) as $line) {
        if (preg_match('#^(content-type|content-length)\s*:\s*(.+)$#i', $line, $m)) header("$m[1]: $m[2]", true);
    }
    echo substr($resp, $hsize);
    exit;
}

// SPA fallback: any unknown non-api path -> web app (or landing for /)
if ($uri === '/' || $uri === '/index.php') {
    readfile($public . '/landing/index.html');
} else {
    readfile($public . '/web-app/index.html');
}
