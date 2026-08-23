Orbitux GRUB Theme

A clean and modern GRUB theme designed to provide a simple
elegant, and customizable boot experience

Features

 - Clean and modern interface
 - Custom Orbitux typography
 - Custom boot menu styling
 - Operating system icons
 - Selected boot entry indicator
 - Boot countdown indicator
 - Custom background support
 - Lightweight and simple design
 - Easy to customize

Preview

./screenshot.png

Installation

1.Copy the theme files
Create a directory for the theme:

```sudo mkdir -p /boot/grub/themes/orbitux```

Copy the Orbitux theme files into it:

```sudo cp -r ./* /boot/grub/themes/orbitux/```

2. Configure GRUB

Open the GRUB configuration file:

```sudo nano /etc/default/grub```

```you can open in any editor you have```

Add or update the following line:

```GRUB_THEME="/boot/grub/themes/orbitux/theme.txt"```

Save the file and regenerate GRUB configuration.

Arch Linux/Manjaro

```sudo grub-mkconfig -o /boot/grub/grub.cfg```

Debian/Ubuntu and derivatives

```sudo update-grub```

Fedora/Redhat base

```sudo grub2-mkconfig -o /boot/grub2/grub.cfg```

3.Reboot

After regenerating the GRUB configuration, reboot your system to see the Orbitux theme.

```if you need help or any please contact me```

Customization

Orbitux is designed to be easy to customize.

The main theme configuration is located in:

theme.txt

You can modify properties such as:

 - Colors
 - Menu position
 - Menu size
 - Fonts
 - Background
 - Text
 - Countdown position
 - Selected item styling

Background images and operating system icons can also be replaced with your own assets.

Orbitux has been tested in multiple Linux environments and with different GRUB configurations.

The theme is designed for systems using GRUB 2.

Requirements
GRUB 2
A Linux system using GRUB as its bootloader

No additional software is required to use the theme.

Version

Current version: 0.3.0

License

Orbitux GRUB Theme is released under the MIT License.

See the LICENSE file for the full license text.

Credits

Created by Orbitux.

If you enjoy the project, consider giving it a ⭐ on GitHub.