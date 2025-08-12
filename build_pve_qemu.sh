#以下两行docker里面运行需要sudo 如果pve里面运行请删除sudo
sudo apt-get update
sudo apt-get install -y libacl1-dev libaio-dev libattr1-dev libcap-ng-dev libcurl4-gnutls-dev libepoxy-dev libfdt-dev libgbm-dev libglusterfs-dev libgnutls28-dev libiscsi-dev libjpeg-dev libnuma-dev libpci-dev libpixman-1-dev libproxmox-backup-qemu0-dev librbd-dev libsdl1.2-dev libseccomp-dev libslirp-dev libspice-protocol-dev libspice-server-dev libsystemd-dev liburing-dev libusb-1.0-0-dev libusbredirparser-dev libvirglrenderer-dev meson python3-sphinx python3-sphinx-rtd-theme quilt xfslibs-dev
ls
df -h
git clone git://git.proxmox.com/git/pve-qemu.git
cd pve-qemu
git reset --hard 839b53bab89fddb7a7fb3a1d722e05df932cce4e
apt install devscripts -y
mk-build-deps --install
git submodule update --init --recursive
cp ../sedPatch-pve-qemu-kvm7-8-anti-dection.sh qemu/
cd qemu
chmod +x sedPatch-pve-qemu-kvm7-8-anti-dection.sh
bash sedPatch-pve-qemu-kvm7-8-anti-dection.sh
cp ../../smbios.h include/hw/firmware/smbios.h
cp ../../smbios.c hw/smbios/smbios.c
sed -i 's/!object_dynamic_cast/object_dynamic_cast/g' hw/vfio/igd.c
git diff > qemu-autoGenPatch.patch
cp qemu-autoGenPatch.patch ../
cd ..
make
cd qemu/
git checkout .
cd ..
