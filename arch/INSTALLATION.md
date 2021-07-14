# Arch Installation

## Download

Download an ISO image from the [Arch Linux Download](https://archlinux.org/download/) page and create a bootable USB flash drive.

## Base Installation

Boot the Arch Linux installation using the USB flash drive.

### Set the keyboard layout

Available layouts can be listed with:

```console
# ls /usr/share/kbd/keymaps/**/*.map.gz | less
```

The default console keymap is US. To modify the layout, append a corresponding file name to loadkeys(1), omitting path and file extension. For example:

```console
# loadkeys de-latin1
```

### Connect to the internet

Check the internet connection:

```console
# ping google.com
```

### Update the system clock

Use timedatectl to ensure the system clock is accurate:

```console
# timedatectl set-ntp true
```

To check the service status, use `timedatectl status`.

### Partition the disks

To identify devices, use fdisk:

```console
# fdisk -l
```

Find the disk to be partitioned and type, for example:

```console
# fdisk /dev/sda
```

in the fdisk prompt you could type `m` for help, but we'll need to follow these options:

- UEFI:
  - `g`: for GPT partition table.
  - `n`: add a new partition.
    - Partition number: `1`
    - First sector: `default`
    - Last sector: `+550M`
- SWAP:
  - `n`: add a new partition.
    - Partition number: `2`
    - First sector: `default`
    - Last sector: `+2G`
- File system:
  - `n`: add a new partition.
    - Partition number: `3`
    - First sector: `default`
    - Last sector: `default`

Now, let's change the partition types. In the `fdisk` prompt type `t`:

- UEFI:
  - Select the partition: `1`
  - List the available types: `L`
  - Select the EFI system: `1` (probably)
- SWAP:
  - Select the partition: `2`
  - List the available types: `L`
  - Select the Linux Swap: `19` (probably)

Last but not least, we need to type `w` to write the tables to the disk.

### Format the partitions

- UEFI:

```console
# mkfs.fat -F32 /dev/sda1
```

- SWAP:

```console
# mkswap /dev/sda2
# swapon /dev/sda2
```

- File system:

```console
# mkfs.ext4 /dev/sda3
# mount /dev/sda3 /mnt
```

### Installation

Once the file system partition is mounted on `/mnt`, let's install the base package:

```console
# pacstrap /mnt base linux linux-firmware
```

### Configure the system

Generate the `fstab`:

```console
# genfstab -U /mnt >> /mnt/etc/fstab
```

Change root into the new system:

```console
# arch-chroot /mnt
```

Set the time zone:

```console
# ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
```

Run hwclock to generate /etc/adjtime:

```console
# hwclock --systohc
```

Install `vim` to edit the following files:

```console
# pacman -S vim
```

Edit `/etc/locale.gen` and uncomment `en_US.UTF-8 UTF-8` and other needed locales. Generate the locales by running:

```console
# locale-gen
```

Create the hostname file:

```console
# echo 'kelvinsp' > /etc/hostname
```

Add matching entries to hosts (`/etc/hosts`):

```text
127.0.0.1   localhost
::1         localhost
127.0.1.1   kelvinsp.localdomain	kelvinsp
```

Set the root password:

```console
# passwd
```

Create a new user:

```console
# useradd -m kelvins
# passwd kelvins
```

Add the new user to the necessary groups:

```console
# usermod -aG wheel,audio,video,optical,storage kelvins
```

Allow members from the `wheel` group to execute any command:

```console
# pacman -S sudo
# visudo
```

Uncomment the following line:

```text
%wheel ALL=(ALL) ALL
```

Install GRUB

```console
# pacman -S grub efibootmgr dosfstools os-prober mtools wireless_tools
```

Make the EFI directory:

```console
# mkdir /boot/EFI
# mount /dev/sda1 /boot/EFI
# grub-install --target=x86_64-efi --bootloader-id=GRUB --recheck
# grub-mkconfig -o /boot/grub/grub.cfg
```

At this point we already have the base system installed. Before rebooting, let's install `networkmanager` to make sure we'll have internet connection:

```console
# pacman -S networkmanager
# systemctl enable NetworkManager
```

### Reboot

Now, lets unmount the directory and reboot the system:

```console
# exit
# umount -R /mnt
# reboot
```

Maybe it is necessary to use the `-l` in the `unmount` command.

After rebooting, log in again with your user and check the internet connection:

```console
# ping google.com
```

## Desktop Installation

Installing xorg:

```console
# pacman -S xorg-server
```

Installing video drivers:

- Intel:
```console
# pacman -S xf86-video-intel libgl mesa
```

- Nvidia:
```console
# pacman -S nvidia nvidia-libgl mesa
```

- AMD:
```console
# pacman -S mesa xf86-video-amdgpu
```

- VirtualBox:
```console
# pacman -S virtualbox-guest-utils virtualbox-guest-modules-arch mesa mesa-libgl
```

### Installing GNOME Applications

From the [GNOME group](https://archlinux.org/groups/x86_64/gnome/):

```console
# pacman -S --noconfirm \
         baobab cheese eog evince file-roller gnome-backgrounds gnome-calculator sushi \
         gnome-color-manager gnome-control-center gnome-disk-utility xdg-user-dirs-gtk mutter nautilus \
         gnome-font-viewer gnome-keyring gnome-menus gnome-screenshot gnome-session gnome-settings-daemon \
         gnome-shell gnome-shell-extensions gnome-themes-extra gnome-tweaks adwaita-icon-theme
```

Install and enable display manager:

```console
# pacman -S gdm
# systemctl enable gdm
```

### Installing Other Applications

```console
# pacman -S --noconfirm \
         grep sed which htop tree git tig wget curl ack xclip kubectl openssh terminator \
         zsh python-pip pyenv cmake docker docker-compose gimp firefox k9s
# systemctl enable docker.service
# sudo gpasswd -a $USER docker
# curl -L http://install.ohmyz.sh | sh
```

## References

- [Arch Linux Installation Guide 2020](https://www.youtube.com/watch?v=PQgyW10xD8s)
- [Arch Linux Wiki](https://wiki.archlinux.org/)
- [É hoje que você instala o Arch Linux! - Tutorial COMPLETO!](https://www.youtube.com/watch?v=4orYC5ARfn8)
