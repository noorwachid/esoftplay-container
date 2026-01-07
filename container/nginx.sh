AUTOGEN=/nginx_autogen.conf

echo '' > $AUTOGEN;

for dir in /var/www/html/*; do
    if [ -d "$dir" ]; then
		base_dir=$(basename "$dir")
		echo "location /$base_dir/ {" >> $AUTOGEN
		echo "    try_files \$uri \$uri/ /$base_dir/index.php?\$args;" >> $AUTOGEN
		echo "}" >> $AUTOGEN
    fi
done

/usr/sbin/nginx -g "daemon off;"

