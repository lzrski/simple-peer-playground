---

title   : Reactive P2P Chat
author  :
  name    : Tadeusz Łazurski
  twitter : @lazurski
  github  : lzrski

---

### Set up new project

```bash
mkdir p2p-chat
cd p2p-chat
git init
npm init
```

> TODO: .gitignore

---

### Install development dependencies...

```bash
npm install --save-dev \
  browserify \
  watchify \
  coffee-reactify
```

> TODO: Use es2015
>
> ```
npm install --save-dev \
  browserify \
  watchify \
  babelify \
  babel-presets-react \
  babel-presets-es2015
```

...and commit changes

```
git add --all .
git commit -m 'Install development dependencies'
```

> PRO TIP: commit on each step

---

### Bootstrap some code

Make some new files:

`index.html`

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Let's Chat!</title>
  </head>
  <body>
    <script src="build/application.js"></script>
  </body>
</html>
```

`src/index.coffee`

```coffee-script
console.log "Hello, there. Let's chat!"
```

---

### Transform and bundle our file

```bash
mkdir build
./node_modules/.bin/browserify \
  -t coffee-reactify \
  -o build/application.js \
  src/index.coffee
```

You should have a file called `build/application.js` with weird looking code. It's a bundle. Not that we reference it in our html file.

---

### Open the html file

```bash
xdg-open index.html # Linux
open index.html     # OSX
```

Then, in the browser, open the console (`alt-ctrl-j` / `alt-cmd-j`).

You should see:

```
Hello, there. Let's chat!
```

> FRIENDLY REMINDER: Commit!

---

### Enter Simple Peer

> TODO:
> * In-browser communication
> * React UI for connecting peers
> * Inter-browser communication

### Discover a bug!

Event handlers attached twice.

> TODO:
> * Fix the bug: keep the state in check
> * Multiple peers?
> * Game?
