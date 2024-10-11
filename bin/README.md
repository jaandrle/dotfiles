# bin — My helpers scritps/executable

## uu
- [./uu](./uu)
- [../.config/uurc](../.config/uurc)

## Lists executables via `npm`, `pip`, …
<details>
<summary>NPM executables</summary>
```
#region >_:npm ls --location global
/home/jaandrle/.nvm/versions/node/v20.16.0/lib
├── @abhagsain/ai-cli@1.3.0
├── @bitwarden/cli@2024.8.1
├── azure-functions-core-tools@4.0.5907
├── catage@1.1.3
├── chrome-remote-interface@0.33.2
├── cordova-res@0.15.4
├── cordova@12.0.0
├── corepack@0.29.3
├── cssmodules-language-server@1.4.1
├── eslint@9.9.1
├── jshint@2.13.6
├── json-server@1.0.0-beta.2
├── mdexpr-agenda@0.6.0 -> ./../../../../../Vzdálené/GitHub/mdexpr-agenda
├── nodejsscript@1.0.2
├── npm@10.8.3
├── typescript-language-server@4.3.3
├── typescript@5.5.4
└── zx@8.1.5
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
aha/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.5.1-3build1 amd64 [instalovaný]
appmenu-gtk2-module/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.7.6-2.1ubuntu2 amd64 [instalovaný]
appmenu-gtk3-module/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.7.6-2.1ubuntu2 amd64 [instalovaný]
aspell-cs/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.51.0-1.3 all [instalovaný]
backintime-qt/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.4.3-1 all [instalovaný]
base-passwd/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.6.3build1 amd64 [instalovaný]
bash/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 5.2.21-2ubuntu4 amd64 [instalovaný]
bat/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.24.0-1build1 amd64 [instalovaný]
ca-certificates/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 20240203 all [instalovaný]
caffeine/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.9.12-1 all [instalovaný]
curl/noble-updates,now 8.5.0-2ubuntu10.4 amd64 [instalovaný]
dash/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.5.12-6ubuntu5 amd64 [instalovaný]
dict/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.13.1+dfsg-1build1 amd64 [instalovaný]
diffpdf/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.1.3.1-2build3 amd64 [instalovaný]
diffutils/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:3.10-1build1 amd64 [instalovaný]
evolution-ews/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.52.0-1build1 amd64 [instalovaný]
evolution-plugin-spamassassin/noble-updates,now 3.52.3-0ubuntu1 amd64 [instalovaný]
evolution/noble-updates,now 3.52.3-0ubuntu1 amd64 [instalovaný]
exo-utils/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 4.18.0-1build4 amd64 [instalovaný]
exuberant-ctags/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:5.9~svn20110310-19build1 amd64 [instalovaný]
fd-find/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 9.0.0-1 amd64 [instalovaný]
festival/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:2.5.0-10 amd64 [instalovaný]
festvox-us-slt-hts/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.2010.10.25-4 all [instalovaný]
ffmpeg/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 7:6.1.1-3ubuntu5 amd64 [instalovaný]
findutils/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 4.9.0-5build1 amd64 [instalovaný]
firefox/mozilla,now 131.0.2~build1 amd64 [instalovaný]
firmware-sof-signed/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2023.12.1-1ubuntu1 all [instalovaný]
flatpak/noble-updates,now 1.14.6-1ubuntu0.1 amd64 [instalovaný]
fonts-oxygen/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 4:5.4.3-4 all [instalovaný]
fprintd/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.94.3-1 amd64 [instalovaný]
gaupol/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.11-2 all [instalovaný]
geany-plugin-addons/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.0-4ubuntu5 amd64 [instalovaný]
geany-plugin-autoclose/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.0-4ubuntu5 amd64 [instalovaný]
geany-plugin-automark/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.0-4ubuntu5 amd64 [instalovaný]
geany-plugin-commander/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.0-4ubuntu5 amd64 [instalovaný]
geany-plugin-ctags/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.0-4ubuntu5 amd64 [instalovaný]
geany-plugin-extrasel/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.0-4ubuntu5 amd64 [instalovaný]
geany-plugin-keyrecord/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.0-4ubuntu5 amd64 [instalovaný]
geany-plugin-macro/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.0-4ubuntu5 amd64 [instalovaný]
geany-plugin-projectorganizer/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.0-4ubuntu5 amd64 [instalovaný]
geany-plugin-vimode/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.0-4ubuntu5 amd64 [instalovaný]
geany/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.0-1build2 amd64 [instalovaný]
gimp-help-en/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.10.34-2 all [instalovaný]
gir1.2-fprint-2.0/noble-updates,now 1:1.94.7+tod1-0ubuntu5~24.04.1 amd64 [instalovaný]
gir1.2-gtk-3.0/noble-updates,now 3.24.41-4ubuntu1.1 amd64 [instalovaný]
gir1.2-vte-2.91/noble-updates,now 0.76.0-1ubuntu0.1 amd64 [instalovaný]
git-delta/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.16.5-5 amd64 [instalovaný]
git-extras/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 7.1.0-1 all [instalovaný]
git-ftp/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.6.0+dfsg-1 all [instalovaný]
git-lfs/noble-updates,now 3.4.1-1ubuntu0.1 amd64 [instalovaný]
gnome-keyring/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 46.1-2build1 amd64 [instalovaný]
greed/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 4.2-1 amd64 [instalovaný]
grep/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.11-4build1 amd64 [instalovaný]
grub-efi-amd64-signed/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.202+2.12-1ubuntu7 amd64 [instalovaný]
grub-efi-ia32-bin/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.12-1ubuntu7 amd64 [instalovaný]
gzip/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.12-1ubuntu3 amd64 [instalovaný]
haveged/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.9.14-1ubuntu2 amd64 [instalovaný]
hostname/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.23+nmu2ubuntu2 amd64 [instalovaný]
hplip/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.23.12+dfsg0-0ubuntu5 amd64 [instalovaný]
hstr/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.1+ds-1build2 amd64 [instalovaný]
htop/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.3.0-4build1 amd64 [instalovaný]
hunspell-cs/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:24.2.1-1 all [instalovaný]
hunspell-en-au/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:2020.12.07-2 all [instalovaný]
hunspell-en-ca/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:2020.12.07-2 all [instalovaný]
hunspell-en-gb/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:24.2.1-1 all [instalovaný]
hunspell-en-za/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:24.2.1-1 all [instalovaný]
hunspell/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.7.2+really1.7.2-10build3 amd64 [instalovaný]
hyphen-cs/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:24.2.1-1 all [instalovaný]
hyphen-en-ca/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.10ubuntu2 all [instalovaný]
hyphen-en-gb/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:24.2.1-1 all [instalovaný]
hyphen-en-us/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.8.8-7build3 all [instalovaný]
init/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.66ubuntu1 amd64 [instalovaný]
isoimagewriter/noble,now 24.08.1-0zneon+24.04+noble+release+build3 amd64 [instalovaný]
jc/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.25.1-1 all [instalovaný]
jq/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.7.1-3build1 amd64 [instalovaný]
kamoso/noble,now 24.08.1-0zneon+24.04+noble+release+build3 amd64 [instalovaný]
karbon/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:3.2.1+dfsg-8build4 amd64 [instalovaný]
katomic/noble,now 4:24.08.1-0zneon+24.04+noble+release+build4 amd64 [instalovaný]
kcron/noble,noble,now 4:24.08.1-0zneon+24.04+noble+release+build4 all [instalovaný]
kdiff3/noble,now 1.11.4-0zneon+24.04+noble+release+build3 amd64 [instalovaný]
kigo/noble,now 4:24.08.1-0zneon+24.04+noble+release+build4 amd64 [instalovaný]
kmahjongg/noble,now 4:24.08.1-0zneon+24.04+noble+release+build4 amd64 [instalovaný]
knights/noble,now 24.08.1-0zneon+24.04+noble+release+build4 amd64 [instalovaný]
konquest/noble,now 4:24.08.1-0zneon+24.04+noble+release+build4 amd64 [instalovaný]
kontrast/noble,now 24.08.1-0zneon+24.04+noble+release+build3 amd64 [instalovaný]
konversation/noble,now 24.08.1-0zneon+24.04+noble+release+build3 amd64 [instalovaný]
krfb/noble,now 4:24.08.1-0zneon+24.04+noble+release+build4 amd64 [instalovaný]
ksystemlog/noble,now 4:24.08.1-0zneon+24.04+noble+release+build5 amd64 [instalovaný]
ktouch/noble,now 4:24.08.1-0zneon+24.04+noble+release+build4 amd64 [instalovaný]
kubuntu-restricted-addons/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 29 amd64 [instalovaný]
kubuntu-restricted-extras/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 67 amd64 [instalovaný]
kup-backup/noble,now 0.10.0-0zneon+24.04+noble+release+build3 amd64 [instalovaný]
kup-client/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.3.6-2.1 all [instalovaný]
kwalletcli/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.03-1build2 amd64 [instalovaný]
labplot/noble,now 2.11.1-1+24.04+noble+release+build2 amd64 [instalovaný]
language-pack-gnome-cs/noble-updates,noble-updates,now 1:24.04+20240817 all [instalovaný]
language-pack-kde-cs/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:24.04.0ubuntu1 all [instalovaný]
language-pack-kde-en/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:24.04.0ubuntu1 all [instalovaný]
lftp/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 4.9.2-2ubuntu1 amd64 [instalovaný]
lib32z1/noble-updates,now 1:1.3.dfsg-3.1ubuntu2.1 amd64 [instalovaný]
libavif-bin/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.0.4-1ubuntu3 amd64 [instalovaný]
libayatana-appindicator3-1/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.5.93-1build3 amd64 [instalovaný]
libayatana-indicator3-7/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.9.4-1build1 amd64 [instalovaný]
libc6/noble-updates,now 2.39-0ubuntu8.3 amd64 [instalovaný]
libdebconfclient0/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.271ubuntu3 amd64 [instalovaný]
libfprint-2-2/noble-updates,now 1:1.94.7+tod1-0ubuntu5~24.04.1 amd64 [instalovaný]
libfprint-2-tod-dev/noble-updates,now 1:1.94.7+tod1-0ubuntu5~24.04.1 amd64 [instalovaný]
libfreetype6/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.13.2+dfsg-1build3 i386 [instalovaný]
libk3b8/noble,now 24.08.1-0zneon+24.04+noble+release+build6 amd64 [instalovaný]
libkf5configqml5/noble,now 5.116.0-1zneon+24.04+noble+release+build3 amd64 [instalovaný]
libkf5guiaddons-bin/noble,now 5.116.0-1zneon+24.04+noble+release+build3 amd64 [instalovaný]
libkf5guiaddons-data/noble,noble,now 5.116.0-1zneon+24.04+noble+release+build3 all [instalovaný]
libkf5i18nlocaledata5/noble,now 5.116.0-1zneon+24.04+noble+release+build3 amd64 [instalovaný]
libkf5kcmutilscore5/noble,now 5.116.0-1zneon+24.04+noble+release+build3 amd64 [instalovaný]
libkf5newstuffwidgets5/noble,now 5.116.0-1zneon+24.04+noble+release+build3 amd64 [instalovaný]
libkf5prisonscanner5/noble,now 5.116.0-1zneon+24.04+noble+release+build3 amd64 [instalovaný]
libkf5syndication5abi1/noble,now 1:5.116.0-1zneon+24.04+noble+release+build2 amd64 [instalovaný]
libkpmcore12/noble,now 24.08.1-0zneon+24.04+noble+release+build4 amd64 [instalovaný]
libkwineffects14/noble,noble,now 4:6.2.0-0zneon+24.04+noble+release+build4 all [instalovaný]
libkwinglutils14/noble,noble,now 4:6.2.0-0zneon+24.04+noble+release+build4 all [instalovaný]
libndp0/noble-updates,now 1.8-1fakesync1ubuntu0.24.04.1 amd64 [instalovaný]
libnotify-bin/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.8.3-1build2 amd64 [instalovaný]
libpcre2-posix3/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 10.42-4ubuntu2 amd64 [instalovaný]
libqt5quickshapes5/noble,now 5.15.14+p24.04+vrelease+git20240821.1031-0 amd64 [instalovaný]
libqt5webview5/noble,now 5.15.14+p24.04+vrelease+git20240821.2140-0 amd64 [instalovaný]
libreoffice-calc/noble-updates,now 4:24.2.6-0ubuntu0.24.04.1 amd64 [instalovaný]
libreoffice-help-cs/noble-updates,noble-updates,now 4:24.2.6-0ubuntu0.24.04.1 all [instalovaný]
libreoffice-help-en-gb/noble-updates,noble-updates,now 4:24.2.6-0ubuntu0.24.04.1 all [instalovaný]
libreoffice-help-en-us/noble-updates,noble-updates,now 4:24.2.6-0ubuntu0.24.04.1 all [instalovaný]
libreoffice-impress/noble-updates,now 4:24.2.6-0ubuntu0.24.04.1 amd64 [instalovaný]
libreoffice-l10n-cs/noble-updates,noble-updates,now 4:24.2.6-0ubuntu0.24.04.1 all [instalovaný]
libreoffice-l10n-en-gb/noble-updates,noble-updates,now 4:24.2.6-0ubuntu0.24.04.1 all [instalovaný]
libreoffice-l10n-en-za/noble-updates,noble-updates,now 4:24.2.6-0ubuntu0.24.04.1 all [instalovaný]
libreoffice-lightproof-en/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.4.3+1.6-3 all [instalovaný]
libreoffice-nlpsolver/noble-updates,noble-updates,now 4:0.9+LibO24.2.6-0ubuntu0.24.04.1 all [instalovaný]
libreoffice-writer/noble-updates,now 4:24.2.6-0ubuntu0.24.04.1 amd64 [instalovaný]
libsecret-1-0/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.21.4-1build3 amd64 [instalovaný]
libsecret-1-dev/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.21.4-1build3 amd64 [instalovaný]
libsodium23/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.0.18-1build3 amd64 [instalovaný]
libvte-2.91-0/noble-updates,now 0.76.0-1ubuntu0.1 amd64 [instalovaný]
libxcvt0/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.1.2-1build1 amd64 [instalovaný]
libxmlb2/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.3.18-1 amd64 [instalovaný]
linux-generic/noble-updates,now 6.8.0-45.45 amd64 [instalovaný]
linux-tuxedo/tuxedo,now 6.8.0-107045.45tux1 amd64 [instalovaný]
lokalize/noble,now 4:24.08.1-0zneon+24.04+noble+release+build5 amd64 [instalovaný]
mediainfo/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 24.01.1-1build2 amd64 [instalovaný]
meld/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.22.2-1 all [instalovaný]
mpack/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.6-18 amd64 [instalovaný]
mystiq/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 20.03.23-3build2 amd64 [instalovaný]
mythes-cs/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:24.2.1-1 all [instalovaný]
mythes-en-au/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.1-6 all [instalovaný]
mythes-en-us/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:24.2.1-1 all [instalovaný]
nala/nala,nala,nala,now 0.15.4 all [instalovaný]
ncdu/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.19-0.1 amd64 [instalovaný]
ncurses-base/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 6.4+20240113-1ubuntu2 all [instalovaný]
ncurses-bin/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 6.4+20240113-1ubuntu2 amd64 [instalovaný]
neon-desktop/noble,now 4+p24.04+vrelease+git20240927.1544 amd64 [instalovaný]
nethack-console/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.6.7-1build3 amd64 [instalovaný]
nfs-common/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:2.6.4-3ubuntu5 amd64 [instalovaný]
nss-passwords/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.4-1 amd64 [instalovaný]
openjdk-17-jdk/noble-updates,now 17.0.12+7-1ubuntu2~24.04 amd64 [instalovaný]
openjdk-17-jre/noble-updates,now 17.0.12+7-1ubuntu2~24.04 amd64 [instalovaný]
openjdk-21-jre/noble-updates,now 21.0.4+7-1ubuntu2~24.04 amd64 [instalovaný]
openjdk-8-jdk/noble-updates,now 8u422-b05-1~24.04 amd64 [instalovaný]
openjdk-8-jre/noble-updates,now 8u422-b05-1~24.04 amd64 [instalovaný]
pandoc/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.1.3+ds-2 amd64 [instalovaný]
partitionmanager/noble,now 24.08.1-0zneon+24.04+noble+release+build3 amd64 [instalovaný]
plasma-discover-backend-flatpak/noble,now 6.2.0-0zneon+24.04+noble+release+build4 amd64 [instalovaný]
plymouth-theme-breeze/noble,now 6.2.0-0zneon+24.04+noble+release+build4 amd64 [instalovaný]
podman/noble-updates,now 4.9.3+ds1-1ubuntu0.1 amd64 [instalovaný]
powertop/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.15-3build1 amd64 [instalovaný]
python3-dbus/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.3.2-5build3 amd64 [instalovaný]
python3-gpg/noble,now 1.23.2-0zneon+24.04+noble+release+build1 amd64 [instalovaný]
python3-nacl/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.5.0-4build1 amd64 [instalovaný]
python3-pkg-resources/nala,nala,nala,now 73.0.1-1 all [instalovaný]
python3-pymacaroons/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.13.0-6 all [instalovaný]
python3-setproctitle/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.3.3-1build2 amd64 [instalovaný]
python3-uno/noble-updates,now 4:24.2.6-0ubuntu0.24.04.1 amd64 [instalovaný]
python3-xlib/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.33-2 all [instalovaný]
python3/noble-updates,now 3.12.3-0ubuntu2 amd64 [instalovaný]
qml-module-org-kde-kcmutils/noble,now 5.116.0-1zneon+24.04+noble+release+build3 amd64 [instalovaný]
qml-module-org-kde-sonnet/noble,now 5.116.0-1zneon+24.04+noble+release+build2 amd64 [instalovaný]
qml-module-org-kde-syntaxhighlighting/noble,now 5.116.0-1zneon+24.04+noble+release+build2 amd64 [instalovaný]
qml-module-qtquick-shapes/noble,now 5.15.14+p24.04+vrelease+git20240821.1031-0 amd64 [instalovaný]
qtchooser/noble,now 66+p24.04+vrelease+git20240903.0820-0 amd64 [instalovaný]
qttools5-dev-tools/noble,now 5.15.14+p24.04+vrelease+git20240821.1232-0 amd64 [instalovaný]
rclone/noble-updates,now 1.60.1+dfsg-3ubuntu0.24.04.1 amd64 [instalovaný]
ripgrep/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 14.1.0-1 amd64 [instalovaný]
rofi/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.7.5-0.1build2 amd64 [instalovaný]
ruby-full/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:3.2~ubuntu1 all [instalovaný]
scrcpy/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.25-1ubuntu1 amd64 [instalovaný]
seahorse/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 43.0-3build2 amd64 [instalovaný]
shellcheck/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.9.0-1 amd64 [instalovaný]
shim-signed/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.58+15.8-0ubuntu1 amd64 [instalovaný]
shogivar/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.55b-3build3 amd64 [instalovaný]
snapd/noble-updates,now 2.63.1+24.04 amd64 [instalovaný]
speech-dispatcher/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.12.0~rc2-2build3 amd64 [instalovaný]
speedcrunch/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.12.0-6build2 amd64 [instalovaný]
sshpass/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.09-1 amd64 [instalovaný]
synaptic/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.91.3build4 amd64 [instalovaný]
sysvinit-utils/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 3.08-6ubuntu3 amd64 [instalovaný]
tesseract-ocr-ces/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:4.1.0-2 all [instalovaný]
texlive-xetex/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2023.20240207-1 all [instalovaný]
tokodon/noble,now 24.08.1-0zneon+24.04+noble+release+build3 amd64 [instalovaný]
translate-shell/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.9.7.1-2 all [instalovaný]
transmission-qt/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 4.0.5-1build5 amd64 [instalovaný]
trash-cli/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.23.11.10-1 all [instalovaný]
tree/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.1.1-2ubuntu3 amd64 [instalovaný]
tuxedo-archive-keyring/tuxedo,tuxedo,now 2022.04.01~tux all [instalovaný]
tuxedo-control-center/tuxedo,now 2.1.13-4 amd64 [instalovaný]
tuxedo-drivers/tuxedo,tuxedo,now 4.8.0 all [instalovaný]
tuxedo-tomte/tuxedo,tuxedo,now 2.39.2 all [instalovaný]
ubuntu-dbgsym-keyring/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2023.11.28.1 all [instalovaný]
ubuntu-minimal/noble-updates,now 1.539.1 amd64 [instalovaný]
ubuntu-restricted-extras/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 67 amd64 [instalovaný]
ubuntu-standard/noble-updates,now 1.539.1 amd64 [instalovaný]
vifm/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.12-1build2 amd64 [instalovaný]
volian-archive-keyring/nala,nala,nala,now 0.3.1 all [instalovaný]
volian-archive-nala/nala,nala,nala,now 0.3.1 all [instalovaný]
vulkan-tools/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.3.275.0+dfsg1-1 amd64 [instalovaný]
watchman/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 4.9.0-7build4 amd64 [instalovaný]
wayland-utils/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.2.0-1build1 amd64 [instalovaný]
wbritish/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2020.12.07-2 all [instalovaný]
webp/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.3.2-0.4build3 amd64 [instalovaný]
wine64/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 9.0~repack-4build3 amd64 [instalovaný]
wireguard-tools/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.0.20210914-1ubuntu4 amd64 [instalovaný]
wl-clipboard/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 2.2.1-1build1 amd64 [instalovaný]
wmctrl/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.07-7ubuntu3 amd64 [instalovaný]
xclip/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 0.13-3 amd64 [instalovaný]
xdotool/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1:3.20160805.1-5build1 amd64 [instalovaný]
xsel/noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,noble,now 1.2.1-1 amd64 [instalovaný]
#endregion
```
</details>
<details>
<summary>SNAP</summary>
```
#region snap list
Název                              Verze                       Rev    Následuje         Vydavatel               Poznámky
android-studio                     2024.1.1.11-Koala           161    latest/stable     snapcrafters✪           classic
bare                               1.0                         5      latest/stable     canonical✓              base
chromium                           129.0.6668.89               2965   latest/stable     canonical✓              -
code                               384ff738                    172    latest/stable     vscode✓                 classic
core                               16-2.61.4-20240607          17200  latest/stable     canonical✓              core
core18                             20240920                    2846   latest/stable     canonical✓              base
core20                             20240705                    2379   latest/stable     canonical✓              base
core22                             20240904                    1621   latest/stable     canonical✓              base
core24                             20240710                    490    latest/stable     canonical✓              base
cups                               2.4.10-1                    1058   latest/stable     openprinting✓           -
dust                               v1.1.1                      19     latest/stable     danie.dejager           -
figma-linux                        0.11.4                      197    latest/stable     youdonthavepermissiony  -
firefox                            131.0.2-1                   5091   latest/stable     mozilla✓                -
fzf-carroarmato0                   0.27.0                      27     latest/stable     carroarmato0            -
gnome-3-28-1804                    3.28.0-19-g98f9e67.98f9e67  198    latest/stable     canonical✓              -
gnome-3-38-2004                    0+git.efb213a               143    latest/stable     canonical✓              -
gnome-42-2204                      0+git.510a601               176    latest/stable     canonical✓              -
gnome-46-2404                      0+git.5d6be1b               48     latest/stable     canonical✓              -
gtk-common-themes                  0.1-81-g442e511             1535   latest/stable     canonical✓              -
kde-frameworks-5-core18            5.67.0                      35     latest/stable     kde✓                    -
kde-frameworks-5-qt-5-15-3-core20  5.87.0                      8      latest/stable     kde✓                    -
kf5-5-110-qt-5-15-11-core22        5.110                       3      latest/stable     kde✓                    -
kf5-5-111-qt-5-15-11-core22        5.111                       7      latest/stable     kde✓                    -
mesa-2404                          24.0.9                      143    latest/stable     canonical✓              -
notepad-plus-plus                  8.6.9                       408    latest/stable     mmtrt                   -
pyqt5-runtime-core20               20.04                       9      latest/stable     rishabh3354             -
qt551                              5.x-core18                  45     latest/stable     keshavnrj✪              -
snapd                              2.63                        21759  latest/stable     canonical✓              snapd
storage-explorer                   1.35.0                      62     latest/stable     msft-storage-tools✓     -
sublime-merge                      2096                        85     latest/stable     snapcrafters✪           classic
teams                              1.5.00.23861                8      latest/stable     msteams✓                -
viu-image-viewer                   v1.3.0-10-g0dba818          1      latest/candidate  rhys-davies             -
wine-platform-6-stable             6.0.4                       19     latest/stable     mmtrt                   -
wine-platform-7-devel-core20       7.22                        24     latest/stable     mmtrt                   -
wine-platform-9-devel-core22       9.19                        28     latest/stable     mmtrt                   -
wine-platform-runtime              v1.0                        390    latest/stable     mmtrt                   -
wine-platform-runtime-core20       v1.0                        138    latest/stable     mmtrt                   -
wine-platform-runtime-core22       v1.0                        85     latest/stable     mmtrt                   -
yazi                               v0.2.4                      x1     -                 -                       classic
#endregion
```
</details>
<details>
<summary>FLATPAK</summary>
```
#region flatpak list
Saber                                                com.adilhanney.saber                                                          0.25.0                                  stable                      system
NormCap                                              com.github.dynobo.normcap                                                     0.5.8                                   stable                      system
Frog                                                 com.github.tenderowl.frog                                                     1.5.2                                   stable                      system
Google Chrome                                        com.google.Chrome                                                             129.0.6668.100-1                        stable                      system
Sigil                                                com.sigil_ebook.Sigil                                                         2.2.0                                   stable                      system
Láhve                                                com.usebottles.bottles                                                        51.13                                   stable                      system
Blobby Volley 2                                      de.blobbyvolley.BlobbyVolley2                                                 1.0                                     stable                      system
Qalculate! (GTK UI)                                  io.github.Qalculate                                                           5.3.0                                   stable                      system
Endless Sky                                          io.github.endless_sky.endless_sky                                             0.10.9                                  stable                      system
Endless Sky High DPI                                 io.github.endless_sky.endless_sky.plugins.endless_sky_high_dpi                0.10.6                                  stable                      system
Text Pieces                                          io.gitlab.liferooter.TextPieces                                               4.1.0                                   stable                      system
VoiceGen                                             io.gitlab.persiangolf.voicegen                                                2.1.0                                   stable                      system
Qt QDBusViewer                                       io.qt.qdbusviewer                                                             6.7                                     stable                      system
Gear Lever                                           it.mijorus.gearlever                                                          2.1.0                                   stable                      system
Minetest                                             net.minetest.Minetest                                                         5.9.1                                   stable                      system
jPDF Tweak                                           net.sourceforge.jpdftweak.jPdfTweak                                           1.1                                     stable                      system
Freedesktop Platform                                 org.freedesktop.Platform                                                      21.08.22                                21.08                       system
Freedesktop Platform                                 org.freedesktop.Platform                                                      freedesktop-sdk-23.08.23                23.08                       system
Freedesktop Platform                                 org.freedesktop.Platform                                                      freedesktop-sdk-24.08.3                 24.08                       system
i386                                                 org.freedesktop.Platform.Compat.i386                                                                                  23.08                       system
Mesa                                                 org.freedesktop.Platform.GL.default                                           21.3.9                                  21.08                       system
Mesa                                                 org.freedesktop.Platform.GL.default                                           24.2.3                                  23.08                       system
Mesa (Extra)                                         org.freedesktop.Platform.GL.default                                           24.2.3                                  23.08-extra                 system
Mesa                                                 org.freedesktop.Platform.GL.default                                           24.2.4                                  24.08                       system
Mesa (Extra)                                         org.freedesktop.Platform.GL.default                                           24.2.4                                  24.08extra                  system
Mesa                                                 org.freedesktop.Platform.GL32.default                                         24.2.3                                  23.08                       system
Intel                                                org.freedesktop.Platform.VAAPI.Intel                                                                                  21.08                       system
Intel                                                org.freedesktop.Platform.VAAPI.Intel                                                                                  23.08                       system
Intel                                                org.freedesktop.Platform.VAAPI.Intel                                                                                  24.08                       system
i386                                                 org.freedesktop.Platform.VAAPI.Intel.i386                                                                             23.08                       system
ffmpeg-full                                          org.freedesktop.Platform.ffmpeg-full                                                                                  23.08                       system
i386                                                 org.freedesktop.Platform.ffmpeg_full.i386                                                                             23.08                       system
openh264                                             org.freedesktop.Platform.openh264                                             2.1.0                                   2.0                         system
openh264                                             org.freedesktop.Platform.openh264                                             2.1.0                                   2.2.0                       system
openh264                                             org.freedesktop.Platform.openh264                                             2.4.1                                   2.4.1                       system
Freedesktop SDK                                      org.freedesktop.Sdk                                                           freedesktop-sdk-23.08.23                23.08                       system
Geany                                                org.geany.Geany                                                               2.0                                     stable                      system
Web                                                  org.gnome.Epiphany                                                            47.0                                    stable                      system
Síťové displeje GNOME                                org.gnome.NetworkDisplays                                                     0.93.0                                  stable                      system
GNOME Application Platform version 45                org.gnome.Platform                                                                                                    45                          system
GNOME Application Platform version 46                org.gnome.Platform                                                                                                    46                          system
GNOME Application Platform version 47                org.gnome.Platform                                                                                                    47                          system
i386                                                 org.gnome.Platform.Compat.i386                                                                                        46                          system
Tau                                                  org.gnome.Tau                                                                 0.12.0                                  stable                      system
Adwaita dark GTK theme                               org.gtk.Gtk3theme.Adwaita-dark                                                                                        3.22                        system
Breeze GTK theme                                     org.gtk.Gtk3theme.Breeze                                                      6.2.0                                   3.22                        system
Inkscape                                             org.inkscape.Inkscape                                                         1.3.2                                   stable                      system
KDE Application Platform                             org.kde.Platform                                                                                                      5.15-23.08                  system
KDE Application Platform                             org.kde.Platform                                                                                                      6.6                         system
KDE Application Platform                             org.kde.Platform                                                                                                      6.7                         system
KDE Software Development Kit                         org.kde.Sdk                                                                                                           6.6                         system
KDE Software Development Kit                         org.kde.Sdk                                                                                                           6.7                         system
Kalkulačka                                           org.kde.kalk                                                                  24.08.1                                 stable                      system
Glaxnimate                                           org.mattbas.Glaxnimate                                                        0.5.4                                   stable                      system
Battle for Wesnoth                                   org.wesnoth.Wesnoth                                                           1.18.2                                  stable                      system
DXVK                                                 org.winehq.Wine.DLLs.dxvk                                                     2.4.1                                   stable-23.08                system
Gecko                                                org.winehq.Wine.gecko                                                                                                 stable-23.08                system
Mono                                                 org.winehq.Wine.mono                                                                                                  stable-23.08                system
q4wine                                               ua.org.brezblock.q4wine                                                       1.3.13                                  stable                      system
#endregion
```
</details>
