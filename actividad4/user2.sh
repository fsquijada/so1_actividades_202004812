#!/bin/bash

# Definir las direcciones de los named pipes
PIPE_FROM_USER2="user1_to_user2"
PIPE_TO_USER2="user2_to_user1"
# Colores para la conversacion
BLUE='\033[0;34m'
NC='\033[0m'

# Crear los named pipes si no existen
if [ ! -p "$PIPE_FROM_USER2" ]; then
    mkfifo "$PIPE_FROM_USER2"
fi

if [ ! -p "$PIPE_TO_USER2" ]; then
    mkfifo "$PIPE_TO_USER2"
fi

# Ciclo infinito del usuario 2
while true; do
    # Leer y mostrar el mensaje del usuario 1
    read message < "$PIPE_FROM_USER2"
    echo "$message"

    # Solicitar mensaje a enviar
    read -p "Tú: " message
    # Enviar mensaje al usuario 1
    echo "$message" > "$PIPE_TO_USER2"
done