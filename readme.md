# Esoftplay Podman Container

## Installation
- installing podman `install podman`
  - on arch `pacman -S podman`
- building the image `sh script/build.sh`
- setup `.env`:
  - create `.env` file on the root project (you can copy from `.env.sample`)
  - change the `WWW_PORT`, `WWW_DIR`, `DB_PORT`, `DB_DIR` to match your setup
- running the container `sh script/run.sh`
- web server is now exposed on the `http://127.0.0.1:$WWW_PORT/`
- create mysql `dev` user:
  - login into container `podman exec -it esoftplay-container sh`
  - login into mysql server `mysql -u root`
  - create local user for web server application:
    - `CREATE USER 'dev'@'localhost' IDENTIFIED BY '123';`
    - `GRANT ALL PRIVILEGES ON *.* TO 'dev'@'localhost';`
  - create remote user for access outside the container
    - `CREATE USER 'dev'@'%' IDENTIFIED BY '123';`
    - `GRANT ALL PRIVILEGES ON *.* TO 'dev'@'%';`
  - update the privileges:
    - `FLUSH PRIVILEGES;`
  - outside the container you can use:
    - mysql client cli: `mysql -u dev -p --port $DB_PORT -h 127.0.0.1 --ssl=off`
    - or any other mysql client application

## Advance

### unresolved local domain nsswitch
Check again: the order in `/etc/nsswitch.conf`

Run:

```bash
sudo nano /etc/nsswitch.conf
```

Find the `hosts:` line and replace it with:

```text
hosts: files mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] myhostname dns
```

Save with `Ctrl+O` → Enter, then exit with `Ctrl+X`.

After that, test again:

```bash
getent ahostsv4 bbo.local
curl --noproxy '*' -I --connect-timeout 5 http://bbo.local/
```
