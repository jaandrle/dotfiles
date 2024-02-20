# bin — My helpers scritps/executable

## uu
- [./uu](./uu)
- [../.config/uurc](../.config/uurc)

## Lists executables via `npm`, `pip`, …
```
>_:npm ls --location global

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
```
```
>_:njs -p 'const executables= s.ls("~/.local/bin"); const pkgName= pkg=> pkg.slice(0, pkg.indexOf(" ")); s.$().run`python3 -m pip list`.split("\n").splice(2).filter(pkg=> executables.indexOf(pkgName(pkg))!==-1).join("\n")'

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
```
