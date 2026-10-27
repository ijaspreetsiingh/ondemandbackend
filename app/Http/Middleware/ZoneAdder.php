<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Config;
use Modules\ZoneManagement\Entities\Zone;

class ZoneAdder
{
    /**
     * Handle an incoming request.
     *
     * @param Request $request
     * @param Closure(Request): (Response|RedirectResponse)  $next
     * @return JsonResponse
     */
    public function handle(Request $request, Closure $next)
    {
        if (request()->is('api/*/customer?*') || request()->is('api/*/customer/*')
            || request()->is('api/*/client?*') || request()->is('api/*/client/*')) {
            $zoneid = $request->header('zoneid');
            $lat = $request->input('latitude', $request->input('lat'));
            $lng = $request->input('longitude', $request->input('lng'));
            $hasCoordinates = is_numeric($lat) && is_numeric($lng);

            // Agar zoneid header nahi hai lekin lat/lng hai, toh coordinates se zone dhund kar set karo
            if (!$zoneid || !preg_match('/^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i', $zoneid)) {
                if ($hasCoordinates) {
                    $zoneid = zone_id_from_coordinates((float) $lat, (float) $lng) ?? $zoneid;
                }
            } elseif ($hasCoordinates) {
                // Header zone stale ho sakta hai (user ne address badla / admin ne zone
                // shift kiya). Coordinates jo zone dete hain wahi authoritative hai —
                // lekin sirf tab badlo jab header zone us point ko contain hi na kare.
                $headerZone = Zone::ofStatus(1)->find($zoneid);
                $pointInHeaderZone = $headerZone
                    && Zone::ofStatus(1)
                        ->whereKey($headerZone->id)
                        ->whereRaw('ST_Contains(coordinates, POINT(?, ?))', [(float) $lng, (float) $lat])
                        ->exists();

                if (!$pointInHeaderZone) {
                    $zoneid = zone_id_from_coordinates((float) $lat, (float) $lng) ?? $zoneid;
                }
            }

            Config::set('zone_id', $zoneid ?? null);

            if ($zoneid && preg_match('/^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i', $zoneid)) {
                $zone = Zone::ofStatus(1)->where('id', $zoneid)->first();
                if (!isset($zone)) {
                    return response()->json(response_formatter(ZONE_404), 401);
                }
            }

            $radius = $request->input('radius');

            Config::set('search_lat', is_numeric($lat) && $lat >= -90 && $lat <= 90 ? (float) $lat : null);
            Config::set('search_lng', is_numeric($lng) && $lng >= -180 && $lng <= 180 ? (float) $lng : null);
            Config::set('search_radius', is_numeric($radius) && $radius > 0 && $radius <= 500 ? (float) $radius : null);
        }
        return $next($request);
    }
}
