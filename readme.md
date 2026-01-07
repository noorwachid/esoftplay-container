# Esoftplay Podman Container

## Installation

- installing podman `install podman`
  - on arch `pacman -S podman`
- building image `sh script/build.sh`
- change the `WWW_PORT`, `WWW_DIR`, `DB_PORT`, `DB_DIR` on `script/run.sh` to match your setup
- running container `sh script/run.sh`
- web server now exposed on the `http://127.0.0.1:WWW_PORT/`
