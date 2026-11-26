SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../.env"

echo "serve to port 80"

sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port $WWW_PORT
sudo iptables -t nat -A OUTPUT -p tcp --dport 80 -j REDIRECT --to-port $WWW_PORT
