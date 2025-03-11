# conectarse a la vps por ssh como root (Ingresar contraseña)

```bash
ssh root@173.212.224.226
```

conectarse como usuario no root (Ingresar contraseña)

```bash
ssh <nombre_usuario>@173.212.224.226
```

actualizar programas vps Linux

```bash
apt update && apt upgrade -y
```

crear usuario

```bash
adduser <nombre_usuario>
```

Darle permisos de sudo (para que pueda ejecutar comandos administrativos cuando sea necesario)

```bash
usermod -aG sudo <nombre_usuario>
```

Cambiar a la cuenta del usuario

```bash
su - <nombre_usuario>
```

Instalar PostgreSQL

```bash
sudo apt install postgresql postgresql-contrib
```

Iniciar Servicio de PostgreSQL

```bash
sudo systemctl enable postgresql.service
sudo systemctl start postgresql.service
```

Moverse a la carpeta del usuario

```bash
cd /home/<nombre_usuario>
```

Crear e ingresar a la carpeta projects

```bash
mkdir projects
cd projects
```

crear e ingresar a la carpeta coffeeTech

```bash
mkdir coffeeTech
cd coffeeTech
```

clonar repositorio de la base de datos desde GitHub

```bash
git clone https://github.com/DavidValenciaX/coffeeTechDB.git
```

ingresar a la carpeta del repositorio

```bash
cd coffeeTechDB
```

Crear la base de datos

```bash
sudo -u postgres createdb coffeeTechDB
```

Ejecutar archivo SQL de creación de tablas

```bash
sudo -u postgres psql -d coffeeTechDB -f coffeeTechDB.sql
```

Comando de inserción de datos

```bash
sudo -u postgres psql -d coffeeTechDB -f coffeeTechData.sql
```

Entrar a la consola de psql

```bash
sudo -u postgres psql
```

Entrar a la base de datos coffeeTechDB en la consola de psql

```bash
sudo -u postgres psql coffeeTechDB
```

Estando en la consola de psql se pueden ejecutar comandos sql o comandos propios como

listar bases de datos

```bash
\l
```

listar tablas de una base de datos

```bash
\dt
```

Ayuda de comandos psql

```bash
\?
```

Salir de psql

```bash
\q
```

Crear backup base de datos

```bash
sudo -u postgres pg_dump coffeeTechDB > coffeeTechDB_backup.sql
```

Recuperar backup de base de datos

```bash
sudo -u postgres psql coffeeTechDB < coffeeTechDB_backup.sql
```

Backup con opciones

Backup con formato custom de postgresql

```bash
sudo -u postgres pg_dump -Fc coffeeTechDB > coffeeTechDB_backup.dump
```

Backup con formato plano

```bash
sudo -u postgres pg_dump -Fp coffeeTechDB > coffeeTechDB_backup.dump
```

Backup con formato tar

```bash
sudo -u postgres pg_dump -Fd coffeeTechDB > coffeeTechDB_backup.dump
```

Backup con formato custom de postgresql

```bash
sudo -u postgres pg_dump -Ft coffeeTechDB > coffeeTechDB_backup.dump
```

Incluir comando de creación de base de datos
Con esta opción se incluye en el volcado la instrucción para crear la base de datos, lo que puede facilitar la restauración

```bash
sudo -u postgres pg_dump -C coffeeTechDB > coffeeTechDB_backup.sql
```

Modo Verbose (Muestra información detallada del proceso)

```bash
sudo -u postgres pg_dump -v coffeeTechDB > coffeeTechDB_backup.sql
```

Filtrado de contenido

- Solo datos: --data-only
- Solo esquema: --schema-only
- Esquema específico: --schema=nombre_esquema
- Tablas específicas: --table=nombre_tabla

Codificación

Define la codificación de salida

```bash
sudo -u postgres pg_dump -E UTF8 coffeeTechDB > coffeeTechDB_backup.sql
```

Si se utilizo un formato personalizado se debe restaurar el backup asi:

```bash
sudo -u postgres pg_restore -d coffeeTechDB coffeeTechDB_backup.dump
```
