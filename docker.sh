sudo pacman -S podman podman-compose
sudo usermod -aG docker "$USER"
sudo systemctl start docker
sudo systemctl enable docker
