# evolent_os_hello

The example app for the Evolent OS of [`evolent_devices`](https://github.com/evolent-labs/evolent_devices): the
starting point for a script that wants its own app on laptops, computers and tablets. Read it with
`evolent_devices/docs/INTEGRATION.md`.

What it shows:
- `server.lua`: `registerApp` on start and on `evolent_devices:ready`, an `onOpen` context, a notification, a callback
  gated by `exports.evolent_devices:appUser(source, 'hello')` (the real gate: it answers only while the player has the
  app open on a device, and only with signal).
- `client.lua`: a message into the page on `evolent_devices:appOpened`, the page's NUI callback checked with
  `isAppPost`, and the same call through the host relay (`evolent_devices:appPost`, `answerAppPost`) for when a fetch
  from inside a screen cannot reach this resource.
- `web`: the page in Svelte 5 and TypeScript, built with Vite into `web/build`. It takes the SDK as the package
  `@evolent/os-app` (`evolent_devices/sdk`), which is bundled into the build. Typing and the select work on a laptop
  screen without code of its own. People nearby see "??" after a roll, never the number (`publish` sends only
  `rolled = true`).
- `web/public/fonts`: Poppins and JetBrains Mono (both SIL Open Font License, the texts are next to them), the fonts
  of the OS chrome. An app page is its own document and gets no fonts from the host: bundle the ones you use and list
  them in `files`.

## Install

Put this folder next to `evolent_devices` and add `ensure evolent_os_hello` after `ensure evolent_devices`. The server
needs `fxmanifest.lua`, the two Lua files and `web/build`.

Never put `evolent_devices` in this resource's `dependencies`: an `ensure evolent_devices` would stop it and not start
it again. The app waits in the panel (`/evdevices`, Apps and integrations) until an admin presses Allow, unless the
resource name is in `Config.trustedResources`. It defaults to on for laptops, computers and tablets and is allowed on
player devices.

## Build

The page takes the SDK from `../../evolent_devices/sdk`, so keep `evolent_devices` next to this folder while you
build. In `web`: `npm install` once, then `npm run build`. `npm run check` is the type check.

Outside the game, `npm run dev` in `web` shows the page: `os.hosted` is false and the page still draws. The SDK harness
loads the built page in a host emulator (typing, intents, the published state, the watch view); see
`evolent_devices/sdk/README.md`.
