<?php

namespace Modules\UserManagement\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureApiUserType
{
    public function handle(Request $request, Closure $next, string ...$allowedTypes): Response
    {
        $user = $request->user();

        if (!$user || !in_array($user->user_type, $allowedTypes, true)) {
            return response()->json([
                'response_code' => 'auth_login_403',
                'message' => 'This account is not allowed to access this app.',
            ], 403);
        }

        return $next($request);
    }
}
