nmap <leader>vd /diff --git<cr>0vG$
command! AIcommit ALTredir !§ai-commit.mjs
command! AIcommitConventional ALTredir !§ai-commit.mjs --format conventional
command! AIcommitGitmoji ALTredir !§ai-commit.mjs --format gitmoji
command! AIcommitGit3moji ALTredir !§ai-commit.mjs --format git3moji
nmap <leader><f1> :AIcommitOP
