# Check systemd failed services
systemctl --failed

# Log files check
sudo journalctl -p 3 -xb

# Update
sudo pacman -Syu

# Aur Update
paru -Syu --aur

#Delete Pacman Cache
paccache -r

# Check Orphan packages
pacman -Qtdq

# Remove Orphan packages
sudo pacman -Rns $(pacman -Qtdq)

# Clean the Cache
#rm -rf .cache/*

# Clean the journal
sudo journalctl --vacuum-time=2weeks

