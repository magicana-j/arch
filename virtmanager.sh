sudo pacman -Syu qemu virt-manager
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt "$USER"
yay -S dnsmasq
sudo virsh net-define /etc/libvirt/qemu/networks/default.xml
sudo virsh net-start default
sudo virsh net-autostart default
