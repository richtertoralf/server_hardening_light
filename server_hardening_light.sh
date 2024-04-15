#!/bin/bash

# Funktion zum Hinzufügen eines Benutzers, Hinzufügen zur sudo-Gruppe und Festlegen des Passworts
add_user_and_sudo() {
    username="$1"
    password="$2"

    # Benutzer anlegen
    sudo adduser --gecos "" "$username"

    # Passwort für den Benutzer festlegen
    echo -e "$password\n$password" | sudo passwd "$username"

    # Zum sudo hinzufügen
    sudo usermod -aG sudo "$username"
}

# Funktion zur Installation von Fail2Ban
install_fail2ban() {
    # Paketliste aktualisieren
    sudo apt update

    # Fail2Ban installieren
    sudo apt install -y fail2ban
}

# Funktion zum Deaktivieren des Root-Zugriffs per SSH
disable_root_ssh() {
    # SSH-Konfigurationsdatei bearbeiten
    sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

    # SSH-Dienst neu starten
    sudo systemctl restart sshd
}

# Benutzer anlegen, zur sudo-Gruppe hinzufügen und Passwort festlegen
add_user_and_sudo "tori" "password123"

# Fail2Ban installieren
install_fail2ban

# Root-Zugriff per SSH deaktivieren
disable_root_ssh

echo "Setup abgeschlossen."
