#!/bin/bash

if command -v chezmoi >/dev/null 2>&1; then
    echo "Applying chezmoi..."
    chezmoi apply
    echo "OK."
else
    echo "chezmoi is not installed. Skipping."
fi


# Remover arquivos antigos
echo "Excluding old config..."
sudo rm -rf /etc/keyd/* 
echo "OK."

# Criar diretórios, se não existirem
echo "Recreating directory structure..."
sudo mkdir -p /etc/keyd/include
echo "/etc/keyd/ directory created."
echo "OK."


echo "Installing new .conf, .inc and include files..."

for f in "$HOME/.config/keyd/"env; do
    [ -e "$f" ] || continue
    echo "Copying $f to /etc/keyd/"
    sudo ln -s "$f" /etc/keyd/
done

# Copiar arquivos de include
for f in "$HOME/.config/keyd/"capslock; do
    [ -e "$f" ] || continue
    echo "Copying $f to /etc/keyd/"
    sudo ln -s "$f" /etc/keyd/
done
echo "OK."

# Copiar arquivos de include
for f in "$HOME/.config/keyd/"*.conf; do
    [ -e "$f" ] || continue
    echo "Copying $f to /etc/keyd/"
    sudo ln -s "$f" /etc/keyd/
done
echo "OK."

echo "Restarting Keyd..."
# Ativar e recarregar o serviço
sudo systemctl enable --now keyd
sudo keyd reload
echo "OK."
echo "Done."

