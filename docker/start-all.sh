#!/bin/sh
# ---------------------------------------------------------------------------
# Railway: SINGLE container me web + queue worker + scheduler
#
# Agar 3 alag services nahi banana chahte, to sirf EXISTING web service ka
# start command ye bana do:
#     sh /var/www/docker/start-all.sh
#
# Ye script:
#   1. queue worker  (background, restart loop)
#   2. scheduler     (background, restart loop)
#   3. php-fpm       (foreground - container alive yahi rehta hai)
#
# Note: Railway ka healthcheck /restart policy web (php-fpm) pe hi lagega.
# ---------------------------------------------------------------------------
cd /var/www || exit 1

echo "[yovo] starting web + worker + scheduler"

# --- Queue worker ---
(
    while true; do
        php artisan queue:work --tries=3 --max-time=3600 --sleep=1 --no-interaction
        echo "[yovo] queue worker exited - restarting in 5s"
        sleep 5
    done
) &

# --- Scheduler ---
(
    while true; do
        php artisan schedule:work
        echo "[yovo] scheduler exited - restarting in 5s"
        sleep 5
    done
) &

# --- Web server (foreground) ---
exec php-fpm
