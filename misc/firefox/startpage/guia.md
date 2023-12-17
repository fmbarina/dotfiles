Jesus isso é meio gambiarresco

## No caminho: ~/.mozilla/firefox/*default*/

Problema: podem ter varios *default* (ex: 9s6fh6-default, 1v84n20-default-release)
Solução(?): Faça em todos

Criar dentro pasta "chrome", nela, jogar 
- conteudo de utils.zip (chrome/ <- utils/)
- todos os scripts que quiser chrome (chrome/ <- arq.ext)

## No caminho de instalacao do firefox

Geralmente:
/usr/lib/firefox 
/usr/lib64/firefox (tava assim no fedora)

Nota do criador original:
> "fx-folder.zip files are packed with paths used by Firefox for Windows.
> Linux users must extract the two files individually to the paths below.
> 
> - /usr/lib/firefox/config.js
> - /usr/lib/firefox/browser/defaults/preferences/config-prefs.js
> 
> I'll say again: Linux users can't just extract folders structure from fx-folder.zip, it won't work. Windows uses \Mozilla Firefox\defaults\pref\config-prefs.js, while Linux uses /firefox/browser/defaults/preferences/config-prefs.js.
> 
> Of course, it's possible that you have installed Firefox in a different location, but /usr/lib/firefox/ is usually the default."

firefox/ <- fx-folder/config.js
firefox/browser/defaults/preferences/ <- fx-folder/defaults/pref/config-prefs.js

## Scripts

newtab-aboutconfig
multifoxContainer
privateTab
rebuild_userChrome
status-bar

## Customização

status-bar.uc.js

#status-bar -> {
  color: initial !important;
  background-color: var(--toolbar-non-lwt-bgcolor);
  max-height: 30px;
  padding: 0 !important;
}

Da pra customizar mais pra ficar melhor, mas tem que decidir se vale mesmo a pena antes...

### Nova aba arquivo local

Com newtab-aboutconfig, criar um arquivo ~/.mozilla/firefox/<perfil>/user.js

Nele, basta incluir:

user_pref("browser.newtab.url", "file:///home/fmbarina/.dot/misc/firefox/startpage/index.html");
