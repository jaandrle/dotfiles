# bin — My helpers scritps/executable

## uu
- [./uu](./uu)
- [../.config/uurc](../.config/uurc)

## Lists executables via `npm`, `pip`, …
<details>
<summary>NPM executables</summary>
```
#region >_:npm ls --location global
/home/jaandrle/.nvm/versions/node/v18.19.0/lib
├── @abhagsain/ai-cli@1.2.3
├── @bitwarden/cli@2023.12.1
├── azure-functions-core-tools@4.0.5455
├── catage@1.1.3
├── chrome-remote-interface@0.33.0
├── corepack@0.24.0
├── cssmodules-language-server@1.3.1
├── eslint@8.56.0
├── jshint@2.13.6
├── json-server@0.17.4
├── mdexpr-agenda@0.6.0 -> ./../../../../../Vzdálené/GitHub/mdexpr-agenda
├── nodejsscript@1.0.0 -> ./../../../../../Vzdálené/GitHub/nodejsscript
├── npm@10.2.5
├── typescript-language-server@4.3.0
├── typescript@5.3.3
└── zx@7.2.3
#endregion
```
</details>
<details>
<summary>PIP executables</summary>
```
#region >_:njs -p 'const executables= s.ls("~/.local/bin"); const pkgName= pkg=> pkg.slice(0, pkg.indexOf(" ")); s.$().run`python3 -m pip list`.split("\n").splice(2).filter(pkg=> executables.indexOf(pkgName(pkg))!==-1).join("\n")'
distro                1.7.0
keyring               23.5.0
mozvpn                0.2.1
names                 0.3.0
openai                0.27.0
pip                   22.0.2
playwright            1.31.1
podman-compose        1.0.3
tqdm                  4.65.0
wheel                 0.37.1
youtube-dl            2021.12.17
#endregion
```
</details>
<details>
<summary>APT</summary>
```
#region apt list | grep '\[instalovaný\]'
aha/jammy,jammy,jammy,jammy,jammy,now 0.5.1-2 amd64 [instalovaný]
appmenu-gtk2-module/jammy,jammy,jammy,jammy,jammy,now 0.7.6-2 amd64 [instalovaný]
appmenu-gtk3-module/jammy,jammy,jammy,jammy,jammy,now 0.7.6-2 amd64 [instalovaný]
aspell-cs/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 0.51.0-1.3 all [instalovaný]
base-passwd/jammy,jammy,jammy,jammy,jammy,now 3.5.52build1 amd64 [instalovaný]
bash/jammy,jammy,jammy,jammy,jammy,now 5.1-6ubuntu1 amd64 [instalovaný]
curlftpfs/jammy,jammy,jammy,jammy,jammy,now 0.9.2-9build1 amd64 [instalovaný]
dash/jammy,jammy,jammy,jammy,jammy,now 0.5.11+git20210903+057cd650a4ed-3build1 amd64 [instalovaný]
datovka/neznámá,now 4.23.6-1 amd64 [instalovaný]
dict/jammy,jammy,jammy,jammy,jammy,now 1.13.0+dfsg-1build2 amd64 [instalovaný]
diffutils/jammy,jammy,jammy,jammy,jammy,now 1:3.8-0ubuntu2 amd64 [instalovaný]
digikam/jammy,now 4:8.2.0-0xneon+22.04+jammy+release+build18 amd64 [instalovaný]
docker-compose/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1.29.2-1 all [instalovaný]
docker/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1.5-2 all [instalovaný]
dpscreenocr/jammy,now 1.4.1-1~jammy1 amd64 [instalovaný]
exo-utils/jammy,jammy,jammy,jammy,jammy,now 4.16.3-1 amd64 [instalovaný]
exuberant-ctags/jammy-security,jammy-updates,now 1:5.9~svn20110310-16ubuntu0.22.04.1 amd64 [instalovaný]
fd-find/jammy-security,jammy-updates,now 8.3.1-1ubuntu0.1 amd64 [instalovaný]
festival/jammy,jammy,jammy,jammy,jammy,now 1:2.5.0-8 amd64 [instalovaný]
festvox-us-slt-hts/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 0.2010.10.25-4 all [instalovaný]
ffmpeg/jammy-security,jammy-updates,now 7:4.4.2-0ubuntu0.22.04.1 amd64 [instalovaný]
findutils/jammy,jammy,jammy,jammy,jammy,now 4.8.0-1ubuntu3 amd64 [instalovaný]
firefox-locale-cs/jammy,now 123.0+build3-0ubuntu0.22.04.1~mt1 amd64 [instalovaný]
firefox-locale-en/jammy,now 123.0+build3-0ubuntu0.22.04.1~mt1 amd64 [instalovaný]
firefox/jammy,now 123.0+build3-0ubuntu0.22.04.1~mt1 amd64 [instalovaný]
firmware-sof-signed/tuxedo,tuxedo,now 2.2.4-1.1 all [instalovaný]
fonts-oxygen/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 4:5.4.3-4 all [instalovaný]
gaupol/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1.10.1-1 all [instalovaný]
gh/neznámá,now 2.44.1 amd64 [instalovaný]
gimp-help-en/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 2.10.0-1 all [instalovaný]
gimp/jammy-security,jammy-updates,now 2.10.30-1ubuntu0.1 amd64 [instalovaný]
gir1.2-gtk-3.0/jammy-updates,now 3.24.33-1ubuntu2 amd64 [instalovaný]
git-extras/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 6.1.0-1 all [instalovaný]
git-lfs/jammy-security,jammy-updates,now 3.0.2-1ubuntu0.2 amd64 [instalovaný]
gnome-keyring/jammy-updates,now 40.0-3ubuntu3 amd64 [instalovaný]
greed/jammy,jammy,jammy,jammy,jammy,now 4.2-1 amd64 [instalovaný]
grep/jammy,jammy,jammy,jammy,jammy,now 3.7-1build1 amd64 [instalovaný]
grub-efi-amd64-signed/jammy-security,jammy-updates,now 1.187.6+2.06-2ubuntu14.4 amd64 [instalovaný]
grub-efi-ia32-bin/jammy-updates,now 2.06-2ubuntu7.2 amd64 [instalovaný]
gzip/jammy-updates,now 1.10-4ubuntu4.1 amd64 [instalovaný]
haveged/jammy,jammy,jammy,jammy,jammy,now 1.9.14-1ubuntu1 amd64 [instalovaný]
hostname/jammy,jammy,jammy,jammy,jammy,now 3.23ubuntu2 amd64 [instalovaný]
hplip/jammy,jammy,jammy,jammy,jammy,now 3.21.12+dfsg0-1 amd64 [instalovaný]
hstr/jammy,jammy,jammy,jammy,jammy,now 2.5+ds-1 amd64 [instalovaný]
htop/jammy,jammy,jammy,jammy,jammy,now 3.0.5-7build2 amd64 [instalovaný]
hunspell-cs/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:7.2.0-2 all [instalovaný]
hunspell-en-au/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:2020.12.07-2 all [instalovaný]
hunspell-en-ca/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:2020.12.07-2 all [instalovaný]
hunspell-en-gb/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:7.2.0-2 all [instalovaný]
hunspell-en-za/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:7.2.0-2 all [instalovaný]
hunspell/jammy,jammy,jammy,jammy,jammy,now 1.7.0-4build1 amd64 [instalovaný]
hyphen-cs/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:7.2.0-2 all [instalovaný]
hyphen-en-ca/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 0.10 all [instalovaný]
hyphen-en-gb/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:7.2.0-2 all [instalovaný]
hyphen-en-us/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 2.8.8-7build2 all [instalovaný]
init/jammy,jammy,jammy,jammy,jammy,now 1.62 amd64 [instalovaný]
isoimagewriter/jammy,now 0.9-0xneon+22.04+jammy+release+build3 amd64 [instalovaný]
jc/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1.17.3-1 all [instalovaný]
jq/jammy,jammy,jammy,jammy,jammy,now 1.6-2.1ubuntu3 amd64 [instalovaný]
kamoso/jammy,now 23.08.4-0xneon+22.04+jammy+release+build25 amd64 [instalovaný]
kate/jammy,now 4:23.08.4-0xneon+22.04+jammy+release+build29 amd64 [instalovaný]
katomic/jammy,now 4:23.08.4-0xneon+22.04+jammy+release+build22 amd64 [instalovaný]
kcron/jammy,jammy,jammy,now 4:23.08.4-0xneon+22.04+jammy+release+build23 all [instalovaný]
kigo/jammy,now 4:23.08.4-0xneon+22.04+jammy+release+build24 amd64 [instalovaný]
kmahjongg/jammy,now 4:23.08.4-0xneon+22.04+jammy+release+build25 amd64 [instalovaný]
knights/jammy,now 23.08.4-0xneon+22.04+jammy+release+build22 amd64 [instalovaný]
konquest/jammy,now 4:23.08.4-0xneon+22.04+jammy+release+build25 amd64 [instalovaný]
konversation/jammy,now 23.08.4-0xneon+22.04+jammy+release+build28 amd64 [instalovaný]
krfb/jammy,now 4:23.08.4-0xneon+22.04+jammy+release+build28 amd64 [instalovaný]
ksystemlog/jammy,now 4:23.08.4-0xneon+22.04+jammy+release+build23 amd64 [instalovaný]
ktouch/jammy,now 4:23.08.4-0xneon+22.04+jammy+release+build26 amd64 [instalovaný]
kubuntu-restricted-addons/jammy,jammy,jammy,jammy,jammy,now 26 amd64 [instalovaný]
kubuntu-restricted-extras/jammy,jammy,jammy,jammy,jammy,now 67 amd64 [instalovaný]
kwalletcli/jammy,jammy,jammy,jammy,jammy,now 3.03-1 amd64 [instalovaný]
labplot/jammy,now 2.10.1-0xneon+22.04+jammy+release+build16 amd64 [instalovaný]
language-pack-gnome-cs/jammy-updates,jammy-updates,now 1:22.04+20240212 all [instalovaný]
language-pack-kde-cs/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:19.10.0ubuntu1 all [instalovaný]
language-pack-kde-en/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:19.10.0ubuntu1 all [instalovaný]
lib32z1/jammy-security,jammy-updates,now 1:1.2.11.dfsg-2ubuntu9.2 amd64 [instalovaný]
libavif-bin/jammy,now 1.0.3-0xneon+22.04+jammy+release+build7 amd64 [instalovaný]
libayatana-appindicator3-1/jammy,jammy,jammy,jammy,jammy,now 0.5.90-7ubuntu2 amd64 [instalovaný]
libayatana-indicator3-7/jammy,jammy,jammy,jammy,jammy,now 0.9.1-1 amd64 [instalovaný]
libc6/jammy-security,jammy-updates,now 2.35-0ubuntu3.6 amd64 [instalovaný]
libdebconfclient0/jammy,jammy,jammy,jammy,jammy,now 0.261ubuntu1 amd64 [instalovaný]
libfprint-2-2/jammy-updates,now 1:1.94.3+tod1-0ubuntu2~22.04.06 amd64 [instalovaný]
libfreetype6/jammy-security,jammy-updates,now 2.11.1+dfsg-1ubuntu0.2 i386 [instalovaný]
libk3b8/jammy,now 23.08.4-0xneon+22.04+jammy+release+build31 amd64 [instalovaný]
libkf5configqml5/jammy,now 5.114.0-0xneon+22.04+jammy+release+build30 amd64 [instalovaný]
libkf5guiaddons-bin/jammy,now 5.114.0-0xneon+22.04+jammy+release+build37 amd64 [instalovaný]
libkf5guiaddons-data/jammy,jammy,jammy,now 5.114.0-0xneon+22.04+jammy+release+build37 all [instalovaný]
libkf5i18nlocaledata5/jammy,now 5.114.0-0xneon+22.04+jammy+release+build32 amd64 [instalovaný]
libkf5kcmutilscore5/jammy,now 5.114.0-0xneon+22.04+jammy+release+build56 amd64 [instalovaný]
libkf5newstuffwidgets5/jammy,now 5.114.0-0xneon+22.04+jammy+release+build53 amd64 [instalovaný]
libkf5prisonscanner5/jammy,now 5.114.0-0xneon+22.04+jammy+release+build32 amd64 [instalovaný]
libkf5syndication5abi1/jammy,now 1:5.114.0-0xneon+22.04+jammy+release+build28 amd64 [instalovaný]
libkpipewire5/jammy,now 5.27.10-0xneon+22.04+jammy+release+build26 amd64 [instalovaný]
libkpmcore12/jammy,now 23.08.4-0xneon+22.04+jammy+release+build26 amd64 [instalovaný]
libkwineffects14/jammy,now 4:5.27.10-0xneon+22.04+jammy+release+build51 amd64 [instalovaný]
libkwinglutils14/jammy,now 4:5.27.10-0xneon+22.04+jammy+release+build51 amd64 [instalovaný]
libncurses5/jammy-security,jammy-updates,now 6.3-2ubuntu0.1 i386 [instalovaný]
libnotify-bin/jammy-updates,now 0.7.9-3ubuntu5.22.04.1 amd64 [instalovaný]
libpcre2-posix3/jammy,now 10.42-3+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
libqt5quickshapes5/jammy,now 5.15.12+p22.04+vrelease+git20240113.1004-0 amd64 [instalovaný]
libqt5webview5/jammy,now 5.15.12+p22.04+vrelease+git20240113.1147-0 amd64 [instalovaný]
libqtav1/jammy,now 1.13.0+ds-4+22.04+jammy+release+build1 amd64 [instalovaný]
libqtavwidgets1/jammy,now 1.13.0+ds-4+22.04+jammy+release+build1 amd64 [instalovaný]
libreoffice-calc/jammy-security,jammy-updates,now 1:7.3.7-0ubuntu0.22.04.4 amd64 [instalovaný]
libreoffice-help-cs/jammy-security,jammy-security,jammy-updates,jammy-updates,now 1:7.3.7-0ubuntu0.22.04.4 all [instalovaný]
libreoffice-help-en-gb/jammy-security,jammy-security,jammy-updates,jammy-updates,now 1:7.3.7-0ubuntu0.22.04.4 all [instalovaný]
libreoffice-help-en-us/jammy-security,jammy-security,jammy-updates,jammy-updates,now 1:7.3.7-0ubuntu0.22.04.4 all [instalovaný]
libreoffice-impress/jammy-security,jammy-updates,now 1:7.3.7-0ubuntu0.22.04.4 amd64 [instalovaný]
libreoffice-kde/jammy-security,jammy-security,jammy-updates,jammy-updates,now 1:7.3.7-0ubuntu0.22.04.4 all [instalovaný]
libreoffice-l10n-cs/jammy-security,jammy-security,jammy-updates,jammy-updates,now 1:7.3.7-0ubuntu0.22.04.4 all [instalovaný]
libreoffice-l10n-en-gb/jammy-security,jammy-security,jammy-updates,jammy-updates,now 1:7.3.7-0ubuntu0.22.04.4 all [instalovaný]
libreoffice-l10n-en-za/jammy-security,jammy-security,jammy-updates,jammy-updates,now 1:7.3.7-0ubuntu0.22.04.4 all [instalovaný]
libreoffice-lightproof-en/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 0.4.3+1.6-2 all [instalovaný]
libreoffice-nlpsolver/jammy-security,jammy-security,jammy-updates,jammy-updates,now 0.9+LibO7.3.7-0ubuntu0.22.04.4 all [instalovaný]
libreoffice-writer/jammy-security,jammy-updates,now 1:7.3.7-0ubuntu0.22.04.4 amd64 [instalovaný]
libsecret-1-0/jammy,jammy,jammy,jammy,jammy,now 0.20.5-2 amd64 [instalovaný]
libsecret-1-dev/jammy,jammy,jammy,jammy,jammy,now 0.20.5-2 amd64 [instalovaný]
libsodium23/jammy,jammy,jammy,jammy,jammy,now 1.0.18-1build2 amd64 [instalovaný]
libxcvt0/jammy,jammy,jammy,jammy,jammy,now 0.1.1-3 amd64 [instalovaný]
libxmlb2/jammy,now 0.3.14-0xneon+22.04+jammy+release+build4 amd64 [instalovaný]
libzxingcore1/jammy,now 1.2.0-1+22.04+jammy+release+build3 amd64 [instalovaný]
linux-generic/jammy-security,jammy-updates,now 5.15.0.94.91 amd64 [instalovaný]
linux-tuxedo-22.04/tuxedo,now 6.5.0.10022.91 amd64 [instalovaný]
lokalize/jammy,now 4:23.08.4-0xneon+22.04+jammy+release+build25 amd64 [instalovaný]
mediainfo/jammy,jammy,jammy,jammy,jammy,now 22.03-1 amd64 [instalovaný]
meld/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 3.20.4-2 all [instalovaný]
merkuro/jammy,now 23.08.4-0xneon+22.04+jammy+release+build21 amd64 [instalovaný]
mlocate/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1.1.15-1ubuntu2 all [instalovaný]
mozillavpn/jammy,now 2.20.0-jammy1 amd64 [instalovaný]
mpack/jammy,jammy,jammy,jammy,jammy,now 1.6-18 amd64 [instalovaný]
mythes-cs/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:7.2.0-2 all [instalovaný]
mythes-en-au/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 2.1-5.6 all [instalovaný]
mythes-en-us/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:7.2.0-2 all [instalovaný]
nala/scar,scar,scar,now 0.15.1 all [instalovaný]
ncdu/jammy,jammy,jammy,jammy,jammy,now 1.15.1-1 amd64 [instalovaný]
ncurses-base/jammy-security,jammy-security,jammy-updates,jammy-updates,now 6.3-2ubuntu0.1 all [instalovaný]
ncurses-bin/jammy-security,jammy-updates,now 6.3-2ubuntu0.1 amd64 [instalovaný]
neon-desktop/jammy,now 4+p22.04+vrelease+git20240125.1419 amd64 [instalovaný]
neon-repositories-launchpad-mozilla/jammy,jammy,jammy,now 0.1+p22.04+vrelease+git20231224.0046 all [instalovaný]
nethack-console/jammy,jammy,jammy,jammy,jammy,now 3.6.6-2build1 amd64 [instalovaný]
newsboat/jammy,jammy,jammy,jammy,jammy,now 2.21-1 amd64 [instalovaný]
nss-passwords/jammy,jammy,jammy,jammy,jammy,now 0.3-2 amd64 [instalovaný]
openjdk-17-jre/jammy-security,jammy-updates,now 17.0.9+9-1~22.04 amd64 [instalovaný]
openjdk-8-jdk/jammy-security,jammy-updates,now 8u392-ga-1~22.04 amd64 [instalovaný]
openjdk-8-jre/jammy-security,jammy-updates,now 8u392-ga-1~22.04 amd64 [instalovaný]
php5.6-cli/jammy,now 5.6.40-68+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php7.4-cli/jammy,now 1:7.4.33-8+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php8.0-bcmath/jammy,now 1:8.0.30-2+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php8.0-cli/jammy,now 1:8.0.30-2+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php8.0-common/jammy,now 1:8.0.30-2+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php8.0-curl/jammy,now 1:8.0.30-2+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php8.0-gd/jammy,now 1:8.0.30-2+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php8.0-intl/jammy,now 1:8.0.30-2+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php8.0-mbstring/jammy,now 1:8.0.30-2+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php8.0-sqlite3/jammy,now 1:8.0.30-2+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php8.0-xml/jammy,now 1:8.0.30-2+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php8.0-zip/jammy,now 1:8.0.30-2+ubuntu22.04.1+deb.sury.org+1 amd64 [instalovaný]
php8.0/jammy,jammy,now 1:8.0.30-2+ubuntu22.04.1+deb.sury.org+1 all [instalovaný]
php8.2/jammy,jammy,now 8.2.15-1+ubuntu22.04.1+deb.sury.org+1 all [instalovaný]
podman/jammy-security,jammy-updates,now 3.4.4+ds1-1ubuntu1.22.04.2 amd64 [instalovaný]
python3-dbus/jammy,jammy,jammy,jammy,jammy,now 1.2.18-3build1 amd64 [instalovaný]
python3-gpg/jammy,now 1.23.2-0xneon+22.04+jammy+release+build6 amd64 [instalovaný]
python3-nacl/jammy,jammy,jammy,jammy,jammy,now 1.5.0-2 amd64 [instalovaný]
python3-pip/jammy-security,jammy-security,jammy-updates,jammy-updates,now 22.0.2+dfsg-1ubuntu0.4 all [instalovaný]
python3-pymacaroons/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 0.13.0-4 all [instalovaný]
python3-setproctitle/jammy,jammy,jammy,jammy,jammy,now 1.2.2-2build1 amd64 [instalovaný]
python3-xlib/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 0.29-1 all [instalovaný]
python3/jammy-security,jammy-updates,now 3.10.6-1~22.04 amd64 [instalovaný]
qml-module-org-kde-kcmutils/jammy,now 5.114.0-0xneon+22.04+jammy+release+build56 amd64 [instalovaný]
qml-module-org-kde-pipewire/jammy,now 5.27.10-0xneon+22.04+jammy+release+build26 amd64 [instalovaný]
qml-module-org-kde-sonnet/jammy,now 5.114.0-0xneon+22.04+jammy+release+build26 amd64 [instalovaný]
qml-module-org-kde-syntaxhighlighting/jammy,now 5.114.0-0xneon+22.04+jammy+release+build26 amd64 [instalovaný]
qml-module-qtquick-shapes/jammy,now 5.15.12+p22.04+vrelease+git20240113.1004-0 amd64 [instalovaný]
rclone/jammy-security,jammy-updates,now 1.53.3-4ubuntu1.22.04.2 amd64 [instalovaný]
ripgrep/jammy-security,jammy-updates,now 13.0.0-2ubuntu0.1 amd64 [instalovaný]
rofi/jammy,jammy,jammy,jammy,jammy,now 1.7.1-0.1 amd64 [instalovaný]
ruby-full/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:3.0~exp1 all [instalovaný]
scrcpy/jammy,jammy,jammy,jammy,jammy,now 1.21-1 amd64 [instalovaný]
seafile-cli/stable,now 9.0.4 amd64 [instalovaný]
seafile-gui/stable,now 9.0.4 amd64 [instalovaný]
seahorse/jammy,jammy,jammy,jammy,jammy,now 41.0-2 amd64 [instalovaný]
shellcheck/jammy,jammy,jammy,jammy,jammy,now 0.8.0-2 amd64 [instalovaný]
shim-signed/jammy-security,jammy-updates,now 1.51.3+15.7-0ubuntu1 amd64 [instalovaný]
shogivar/jammy,jammy,jammy,jammy,jammy,now 1.55b-3build1 amd64 [instalovaný]
speech-dispatcher/jammy-updates,now 0.11.1-1ubuntu3 amd64 [instalovaný]
sshpass/jammy,jammy,jammy,jammy,jammy,now 1.09-1 amd64 [instalovaný]
sysvinit-utils/jammy,jammy,jammy,jammy,jammy,now 3.01-1ubuntu1 amd64 [instalovaný]
tesseract-ocr-ces/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 1:4.00~git30-7274cfa-1.1 all [instalovaný]
tokodon/jammy,now 23.08.4-0xneon+22.04+jammy+release+build15 amd64 [instalovaný]
translate-shell/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 0.9.6.12-1 all [instalovaný]
trash-cli/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 0.17.1.14-5build1 all [instalovaný]
tuxedo-archive-keyring/tuxedo,tuxedo,now 2022.04.01~tux all [instalovaný]
tuxedo-control-center/tuxedo,now 2.1.6 amd64 [instalovaný]
tuxedo-dgpu-run/tuxedo,tuxedo,now 1.1.0 all [instalovaný]
tuxedo-drivers/tuxedo,tuxedo,now 4.2.2 all [instalovaný]
tuxedo-tomte/tuxedo,tuxedo,now 2.24.1 all [instalovaný]
ubuntu-dbgsym-keyring/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 2021.03.26 all [instalovaný]
ubuntu-make/jammy,jammy,now 22.10+202401071313~ubuntu22.04.1 all [instalovaný]
ubuntu-minimal/jammy-updates,now 1.481.1 amd64 [instalovaný]
ubuntu-restricted-extras/jammy,jammy,jammy,jammy,jammy,now 67 amd64 [instalovaný]
ubuntu-standard/jammy-updates,now 1.481.1 amd64 [instalovaný]
vifm/jammy,jammy,jammy,jammy,jammy,now 0.12-1 amd64 [instalovaný]
vim-gtk/jammy,jammy,now 2:9.0.0749-0york0~22.04 all [instalovaný]
volian-archive-keyring/scar,scar,scar,now 0.2.0 all [instalovaný]
volian-archive-nala/scar,scar,scar,now 0.2.0 all [instalovaný]
vulkan-tools/jammy,jammy,jammy,jammy,jammy,now 1.3.204.0+dfsg1-1 amd64 [instalovaný]
wayland-utils/jammy,now 1.0.0.1.0.0-0xneon+22.04+jammy+release+build1 amd64 [instalovaný]
wbritish/jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,jammy,now 2020.12.07-2 all [instalovaný]
webp/jammy-security,jammy-updates,now 1.2.2-2ubuntu0.22.04.2 amd64 [instalovaný]
wine64/jammy,jammy,jammy,jammy,jammy,now 6.0.3~repack-1 amd64 [instalovaný]
wmctrl/jammy,jammy,jammy,jammy,jammy,now 1.07-7build1 amd64 [instalovaný]
xclip/jammy,jammy,jammy,jammy,jammy,now 0.13-2 amd64 [instalovaný]
xdotool/jammy,jammy,jammy,jammy,jammy,now 1:3.20160805.1-4 amd64 [instalovaný]
xsel/jammy,jammy,jammy,jammy,jammy,now 1.2.0+git9bfc13d.20180109-3 amd64 [instalovaný]
#endregion
```
</details>
<details>
<summary>SNAP</summary>
```
#region snap list
Název                              Verze                       Rev    Následuje         Vydavatel               Poznámky
android-studio                     2023.1.1.28-Hedgehog        148    latest/stable     snapcrafters*           classic
bare                               1.0                         5      latest/stable     canonical**             base
chromium                           121.0.6167.184              2757   latest/stable     canonical**             -
code                               903b1e9d                    152    latest/stable     vscode**                classic
core                               16-2.61.1                   16574  latest/stable     canonical**             core
core18                             20231027                    2812   latest/stable     canonical**             base
core20                             20240111                    2182   latest/stable     canonical**             base
core22                             20240111                    1122   latest/stable     canonical**             base
cups                               2.4.7-3                     1024   latest/stable     openprinting**          -
figma-linux                        0.11.3                      189    latest/stable     youdonthavepermissiony  -
fzf-carroarmato0                   0.27.0                      27     latest/stable     carroarmato0            -
gnome-3-28-1804                    3.28.0-19-g98f9e67.98f9e67  198    latest/stable     canonical**             -
gnome-3-38-2004                    0+git.efb213a               143    latest/stable     canonical**             -
gnome-42-2204                      0+git.ff35a85               141    latest/stable     canonical**             -
gtk-common-themes                  0.1-81-g442e511             1535   latest/stable     canonical**             -
kde-frameworks-5-core18            5.67.0                      35     latest/stable     kde**                   -
kde-frameworks-5-qt-5-15-3-core20  5.87.0                      8      latest/stable     kde**                   -
kf5-5-110-qt-5-15-11-core22        5.110                       3      latest/stable     kde**                   -
kf5-5-111-qt-5-15-11-core22        5.111                       7      latest/stable     kde**                   -
notepad-plus-plus                  8.6.4                       399    latest/stable     mmtrt                   -
qt551                              5.x-core18                  43     latest/stable     keshavnrj*              -
snapd                              2.61.1                      20671  latest/stable     canonical**             snapd
storage-explorer                   1.32.1                      58     latest/stable     msft-storage-tools**    -
teams                              1.5.00.23861                8      latest/stable     msteams**               -
viu-image-viewer                   v1.3.0-10-g0dba818          1      latest/candidate  rhys-davies             -
wine-platform-6-stable             6.0.4                       19     latest/stable     mmtrt                   -
wine-platform-7-devel-core20       7.22                        24     latest/stable     mmtrt                   -
wine-platform-runtime              v1.0                        357    latest/stable     mmtrt                   -
wine-platform-runtime-core20       v1.0                        100    latest/stable     mmtrt                   -
#endregion
```
</details>
<summary>FLATPAK</summary>
```
#region flatpak list
Text Pieces	com.github.liferooter.textpieces	3.4.1	stable	system
Flatseal	com.github.tchx84.Flatseal	2.1.1	stable	system
Frog	com.github.tenderowl.frog	1.5.1	stable	system
Google Chrome	com.google.Chrome	121.0.6167.184-1	stable	system
Sigil	com.sigil_ebook.Sigil	2.0.1	stable	system
Láhve	com.usebottles.bottles	51.11	stable	system
Blobby Volley 2	de.blobbyvolley.BlobbyVolley2	1.0	stable	system
Qalculate! (GTK UI)	io.github.Qalculate	4.9.0	stable	system
Endless Sky	io.github.endless_sky.endless_sky	0.10.4	stable	system
Gear Lever	it.mijorus.gearlever	1.3.0	stable	system
Minetest	net.minetest.Minetest	5.8.0	stable	system
jPDF Tweak	net.sourceforge.jpdftweak.jPdfTweak	1.1	stable	system
Freedesktop Platform	org.freedesktop.Platform	20.08.21	20.08	system
Freedesktop Platform	org.freedesktop.Platform	22.08.21	22.08	system
Freedesktop Platform	org.freedesktop.Platform	23.08.11	23.08	system
i386	org.freedesktop.Platform.Compat.i386		23.08	system
Mesa	org.freedesktop.Platform.GL.default	21.1.8	20.08	system
Mesa	org.freedesktop.Platform.GL.default	23.3.5	22.08	system
Mesa (Extra)	org.freedesktop.Platform.GL.default	23.3.5	22.08-extra	system
Mesa	org.freedesktop.Platform.GL.default	23.3.4	23.08	system
Mesa (Extra)	org.freedesktop.Platform.GL.default	23.3.4	23.08-extra	system
Mesa	org.freedesktop.Platform.GL32.default	23.3.4	23.08	system
Intel	org.freedesktop.Platform.VAAPI.Intel		20.08	system
Intel	org.freedesktop.Platform.VAAPI.Intel		22.08	system
Intel	org.freedesktop.Platform.VAAPI.Intel		23.08	system
ffmpeg-full	org.freedesktop.Platform.ffmpeg-full		23.08	system
i386	org.freedesktop.Platform.ffmpeg_full.i386		23.08	system
openh264	org.freedesktop.Platform.openh264	2.1.0	2.0	system
openh264	org.freedesktop.Platform.openh264	2.1.0	2.2.0	system
Freedesktop SDK	org.freedesktop.Sdk	20.08.21	20.08	system
Freedesktop SDK	org.freedesktop.Sdk	22.08.21	22.08	system
Web	org.gnome.Epiphany	45.2	stable	system
Síťové displeje GNOME	org.gnome.NetworkDisplays	0.92.1	stable	system
GNOME Application Platform version 44	org.gnome.Platform		44	system
GNOME Application Platform version 45	org.gnome.Platform		45	system
i386	org.gnome.Platform.Compat.i386		45	system
Adwaita dark GTK theme	org.gtk.Gtk3theme.Adwaita-dark		3.22	system
Breeze GTK theme	org.gtk.Gtk3theme.Breeze	5.27.8	3.22	system
Breeze Gtk theme	org.gtk.Gtk3theme.Breeze-Dark		3.22	system
Inkscape	org.inkscape.Inkscape	1.3.2	stable	system
KDE Application Platform	org.kde.Platform		5.15-22.08	system
KDE Application Platform	org.kde.Platform		5.15-23.08	system
KDE Application Platform	org.kde.Platform		6.5	system
Kalkulačka	org.kde.kalk	23.08.4	stable	system
Glaxnimate	org.mattbas.Glaxnimate	0.5.4	stable	system
Battle for Wesnoth	org.wesnoth.Wesnoth	1.14.17	1.14	system
DXVK	org.winehq.Wine.DLLs.dxvk	2.3	stable-23.08	system
Gecko	org.winehq.Wine.gecko		stable-23.08	system
Mono	org.winehq.Wine.mono		stable-23.08	system
q4wine	ua.org.brezblock.q4wine	1.3.13	stable	system
#endregion
```
</details>
