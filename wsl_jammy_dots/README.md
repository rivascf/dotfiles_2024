# Dotfiles and config scripts in WSL

## Outside WSL Ubuntu - Wndows side

Ubuntu distro installed

Command `wsl -l` output:

```console
Distribuciones de subsistema de Windows para Linux:
Ubuntu (predeterminado)
```

Command `wsl -l -v` output:

```console
  NAME      STATE           VERSION
* Ubuntu    Running         2
```

Command `wsl --export <distro> <filename.tar>` to export wsl-ubuntu distro backup.

```console
$ wsl --export Ubuntu wsl-ubuntu22_04_ai.tar
Exportación en curso. Esta operación puede tardar unos minutos...

⁞ (Varios minutos depués)

Exportación en curso. Esta operación puede tardar unos minutos....: ./home/arrusr/.cache/git/credential/socket: pax format cannot archive sock
La operación se completó correctamente.
```

Command `wsl --unregister <DistroName>` to remove wsl-ubuntu distro.

```console
wsl --unregister Ubuntu
Anulando el registro.
La operación se completó correctamente.
```

## In WSL Ubuntu

Command `lsb_release -a` output:

```console
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.5 LTS
Release:        22.04
Codename:       jammy
```

Current Disk `df -h` used:

```console
Filesystem      Size  Used Avail Use% Mounted on
none            7.8G     0  7.8G   0% /usr/lib/modules/5.15.153.1-microsoft-standard-WSL2
none            7.8G  4.0K  7.8G   1% /mnt/wsl
drivers         934G  445G  490G  48% /usr/lib/wsl/drivers
/dev/sdc       1007G   68G  888G   8% /
none            7.8G   88K  7.8G   1% /mnt/wslg
none            7.8G     0  7.8G   0% /usr/lib/wsl/lib
rootfs          7.8G  2.2M  7.8G   1% /init
none            7.8G  964K  7.8G   1% /run
none            7.8G     0  7.8G   0% /run/lock
none            7.8G     0  7.8G   0% /run/shm
tmpfs           4.0M     0  4.0M   0% /sys/fs/cgroup
none            7.8G  212K  7.8G   1% /mnt/wslg/versions.txt
none            7.8G  212K  7.8G   1% /mnt/wslg/doc
C:\             934G  445G  490G  48% /mnt/c
D:\             1.9T  1.2T  679G  64% /mnt/d
E:\             932G  905G   28G  98% /mnt/e
snapfuse        128K  128K     0 100% /snap/bare/5
snapfuse         74M   74M     0 100% /snap/core22/1663
snapfuse         75M   75M     0 100% /snap/core22/1621
snapfuse         92M   92M     0 100% /snap/gtk-common-themes/1535
snapfuse         41M   41M     0 100% /snap/snapd/20290
snapfuse         39M   39M     0 100% /snap/snapd/21759
snapfuse        132M  132M     0 100% /snap/ubuntu-desktop-installer/1276
snapfuse        132M  132M     0 100% /snap/ubuntu-desktop-installer/1286
total           5.7T  3.0T  2.6T  54% -
```

Current disk used, only for root space, cmd `df -h | awk '$NF=="/"{print $0}'`:

```console
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdc       1007G   68G  888G   8% /
```

Command `ollama list` output:

```consle

NAME               	ID          	SIZE  	MODIFIED
llava-llama3:latest	44c161b1f465	5.5 GB	2 weeks ago
llama3.2:latest    	a80c4f17acd5	2.0 GB	2 weeks ago
deepseek-coder:6.7b	ce298d984115	3.8 GB	6 weeks ago
codegemma:latest   	0c96700aaada	5.0 GB	6 weeks ago
gemma2:latest      	ff02c3702f32	5.4 GB	6 weeks ago
llava:latest       	8dd30f6b0cb1	4.7 GB	6 weeks ago
llama2:latest      	78e26419b446	3.8 GB	6 weeks ago
```

Command `docker images list` output:

```console
REPOSITORY                      TAG       IMAGE ID       CREATED       SIZE
ghcr.io/open-webui/open-webui   cuda      b466f6839adf   7 weeks ago   8.01GB
ghcr.io/open-webui/open-webui   main      c72aa3b0b9ee   7 weeks ago   3.69GB
```

Command `docker container list` output:

```console
CONTAINER ID   IMAGE                                COMMAND           CREATED       STATUS                   PORTS     NAMES
0e298edf1611   ghcr.io/open-webui/open-webui:main   "bash start.sh"   6 weeks ago   Up 9 minutes (healthy)             open-webui
```

## Custom apps and devcode

Directory `ll ~/Dev`:

```console
drwxr-xr-x arrusr arrusr 4.0 KB Sep 24 2024 08:03:56 PM  PaLI
drwxr-xr-x arrusr arrusr 4.0 KB Sep 24 2024 07:49:11 PM  rt-2
drwxr-xr-x arrusr arrusr 4.0 KB Oct 01 2024 05:42:27 PM  voice_ai
```

## References used

### Blogs

1. _How to completely remove a Linux distro from the Windows Subsystem for Linux (WSL)_ [Windows Central - How's to...](https://www.windowscentral.com/how-completely-remove-linux-distro-wsl).
   _"Installing a Linux distro in WSL is easier than ever, but how do you properly remove one?"_

   > While WSL can be disposable, it's also a good idea to back up your installations so if you do get rid of one you can get back to where you were a little easier.
   >
   > Backing up is a pretty straightforward process that involves exporting to a .tar file. Our guides on exporting and importing Linux installs in WSL will take you through the process step by step, but the main commands you need are as follows:
   >
   > `wsl --export <distro> <filename.tar>`
   >
   > `wsl --import <distro> <install location=""> <filename> </filename></install></distro></filename.tar></distro>`
   >
   > The process doesn't take too long, and it's particularly useful if you plan on making frequent changes to your WSL installs.

1. _How to uninstall the WSL installation of Ubuntu 20.04 from Windows 10?_ [Ubuntu Ask - Blog's post](https://askubuntu.com/questions/1261664/how-to-uninstall-the-wsl-installation-of-ubuntu-20-04-from-windows-10)

   > Uninstalling a distro via the settings or store didn't work for me. What did was:
   >
   > Enter a cmd or PowerShell prompt, `wsl -l` to see a list of installed distro names
   > `wsl --unregister <DistroName>`

1. _Virtualization applications don't work together with Hyper-V, Device Guard, and Credential Guard_ [Microsoft Learn](https://learn.microsoft.com/en-us/troubleshoot/windows-client/application-management/virtualization-apps-not-work-with-hyper-v)
