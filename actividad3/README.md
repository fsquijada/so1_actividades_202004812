# Crear un servicio systemd para imprimir saludos y fecha actual

## 1. Se crea el script

Crea un script, con cualquier nombre y con extensión `.sh` por convención, con el siguiente contenido:

```bash
#!/bin/bash
while true
do
    echo "Hola $USER. La fecha y hora actual es: $(date)"
    sleep 1
done
```

El archivo en esta ocasión tendrá el nombre de `saludo.sh`.

Al tener el archivo listo, se guardará en cualquier ubicación del sistema, en esta ocasión se realizará en la ruta `/usr/local/bin/saludo.sh`.

También se debe de asegurar de que tenga permisos de ejecución (`chmod +x /usr/local/bin/saludo.sh`).

## 2. Se Crea el archivo de unidad de systemd

Se crea un archivo, en este caso `saludo.service` en la ruta `/etc/systemd/system/` con el siguiente contenido:

```ini
[Unit]
Description=Servicio de saludo infinito
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/saludo.sh
Restart=always

[Install]
WantedBy=multi-user.target
```

## 3. Habilitar el servicio

### Con el sistema

Para habilitar el servicio para que se inicie con el sistema, se ejecuta el siguiente comando:

```bash
sudo systemctl enable saludo.service
```

### Manualmente

También se puede iniciar el servicio manualmente con el siguiente comando:

```bash
sudo systemctl start saludo.service
```

## 4. Detener el servicio

Para detener el servicio, se utiliza el siguiente comando:

```bash
sudo systemctl stop saludo.service
```

## 6. Deshabilitar el servicio

Si deseamos deshabilitar el servicio para que no se inicie automáticamente al arrancar el sistema, ejecutamos:

```bash
sudo systemctl disable saludo.service
```

## 7. Verificar logs del servicio

Se Puede verificar los logs del servicio utilizando el comando `journalctl`:

```bash
sudo journalctl -u saludo.service
```
