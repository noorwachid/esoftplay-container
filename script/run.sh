SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../.env"

podman run -d \
	--replace --name esoftplay-container \
	-p "$WWW_PORT:80" \
	-v "$WWW_DIR:/var/www/html" \
	-p "$DB_PORT:3306" \
	-v "$DB_DIR:/var/lib/mysql" \
	esoftplay-image

echo "running on http://127.0.0.1:$WWW_PORT/"
