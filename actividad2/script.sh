# Esta linea servirá para indicar que se utilizará el interprete bash
#!/bin/bash

# Esta linea sirve para solicitar y leer y almacenar el usuario de github que se ingrese.
read -p "Ingresa el nombre de usuario de GitHub: " GITHUB_USER

# Esta linea sirve para hacer la consulta del usuario en la api de github
response=$(curl -s "https://api.github.com/users/$GITHUB_USER")

# Con estas lineas se extraen los datos que se necesitan del script
idUser=$(echo "$response" | jq -r '.id')
created_at=$(echo "$response" | jq -r '.created_at')

# Esta linea imprime el mensaje en consola
echo "Hola $GITHUB_USER. User ID: $idUser. Cuenta creada el: $created_at."

# Crear el directorio /tmp/<fecha> por si no existiese
fecha=$(date +"%Y%m%d")
directorioLog="/tmp/$fecha"
mkdir -p "$directorioLog"

# Crear el archivo de log en la ruta creada anteriormente: /tmp/<fecha>/saludos.log
archivoLog="$directorioLog/saludos.log"
echo "Hola $GITHUB_USER. User ID: $idUser. Cuenta creada el: $created_at." > "$archivoLog"

