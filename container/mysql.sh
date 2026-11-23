
[ -z "$(ls -A /var/lib/mysql)" ] && mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld
chmod 755 /run/mysqld

/usr/bin/mysqld \
	--skip-networking=off \
	--bind-address=0.0.0.0 \
	--sql_mode='' \
	--user=mysql \
	--datadir=/var/lib/mysql
