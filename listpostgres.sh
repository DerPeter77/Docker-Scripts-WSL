#!/bin/bash

# Listet Docker-Container auf, die "postgres" im Namen oder Image haben
containers=$(docker ps -a --filter "name=postgres" --filter "ancestor=postgres" --format "{{.ID}} {{.Names}} {{.Image}} {{.Status}} {{.Ports}}")

# Überprüfen, ob Container gefunden wurden
if [ -z "$containers" ]; then
  echo "Keine Container gefunden, die 'postgres' im Namen oder Image haben."
  exit 1
fi

# Container in eine Liste packen und anzeigen
echo "Gefundene Container:"
echo "----------------------------------------"
echo " ID Container-ID Name Image Status Ports"
echo " "
echo "$containers" | nl -w 2 -s '. '

# Benutzer zur Auswahl auffordern
echo " "
echo "----------------------------------------"
echo "Wähle einen Container aus (1, 2, ...):"
echo ""
read -r selection

# Überprüfen, ob die Auswahl gültig ist
selected_container=$(echo "$containers" | sed -n "${selection}p")
if [ -z "$selected_container" ]; then
  echo "Ungültige Auswahl."
  exit 1
fi

# Ausgewählten Container anzeigen
echo "Du hast ausgewählt:"
echo "$selected_container"

# Container-ID extrahieren
container_id=$(echo "$selected_container" | awk '{print $1}')

# Aktionen anbieten
echo "Wähle eine Aktion aus:"
echo "1. Starten"
echo "2. Stoppen"
echo "3. Löschen"
read -r action

case $action in
  1)
    echo "Starte Container $container_id..."
    docker start "$container_id"
    ;;
  2)
    echo "Stoppe Container $container_id..."
    docker stop "$container_id"
    ;;
  3)
    echo "Lösche Container $container_id..."
    docker stop "$container_id"
    docker rm "$container_id"
    ;;
  *)
    echo "Ungültige Aktion."
    exit 1
    ;;
esac