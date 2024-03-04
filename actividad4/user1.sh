#!/bin/bash

# Definir las direcciones de los named pipes
PIPE_FROM_USER1="user2_to_user1"
PIPE_TO_USER1="user1_to_user2"
# Colores para la conversacion
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Crear los named pipes si no existen
if [ ! -p "$PIPE_FROM_USER1" ]; then
    mkfifo "$PIPE_FROM_USER1"
fi

if [ ! -p "$PIPE_TO_USER1" ]; then
    mkfifo "$PIPE_TO_USER1"
fi

# Ciclo infinito del usuario 1
while true; do
    # Solicitar mensaje a enviar
    read -p "Tú: " message
    # Enviar mensaje al usuario 2
    echo -e "${BLUE}Usuario 1: $message${NC}" > "$PIPE_TO_USER1"

    # Leer y mostrar el mensaje del usuario 2
    read message < "$PIPE_FROM_USER1"
    echo -e "${BLUE}Usuario 2: $message${NC}"
done