SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../.env"

echo "initializing webserver"
echo "  forwarding port $WWW_PORT"
echo "  mounting dir $WWW_DIR"
echo "initializing database"
echo "  forwarding port $DB_PORT"
echo "  mounting dir $DB_DIR"

podman run -d \
	--replace --name esoftplay-container \
	-p "$WWW_PORT:80" \
	-v "$WWW_DIR:/var/www/html" \
	-p "$DB_PORT:3306" \
	-v "$DB_DIR:/var/lib/mysql" \
	--add-host="bbo.local;api.bbo.local:127.0.0.1" \
	esoftplay-image

echo "listening on http://127.0.0.1:$WWW_PORT/"
