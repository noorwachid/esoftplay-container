WWW_PORT=8000
WWW_DIR="~/dev/project/esoftplay"

DB_PORT=8006
DB_DIR="~/dev/container/esoftplay/db"

podman run -d \
	--replace --name esoftplay-container \
	-p "$WWW_PORT:80" \
	-v "$WWW_PATH:/var/www/html" \
	-p "$DB_PORT:3306" \
	-v "$DB_PATH:/var/lib/mysql" \
	esoftplay-image

