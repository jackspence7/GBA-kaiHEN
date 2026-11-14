# GBA kaiHEN

Native mGBA for the Nintendo Switch 2, running as homebrew under kaiHEN.

Full speed Game Boy Advance emulation on the Switch 2. mGBA is compiled to
native AArch64 and loaded through the kaiHEN homebrew menu. I first tried
running mGBA as JavaScript inside Civilization VII, but it got about 1 fps
because that JS engine has no JIT, so this is a native build instead.

## What's tested

Pokemon Emerald is the only game tested on real hardware so far. It runs at
full speed with sound, input, in game saves, save states, and all three screen
modes.

Not tested yet: GB and GBC games, fast forward, cheats, and bilinear filtering.
Those come from mGBA's existing Switch port and should work, but they have not
been checked on the Switch 2.

## Requirements

You need a Nintendo Switch 2 with kaiHEN already set up. This repo is only the
emulator, not the kaiHEN tool.

Tested on firmware 23.0.1. kaiHEN is patched in 23.5.0, so stay on 23.0.1 or
earlier. kaiHEN also has to be relaunched from a PC after every power off.

See the kaiHEN repo for the full setup: https://github.com/ouncebrew/kaihen

## Install

1. Download mgba.nro from the latest release.
2. Copy it to /switch/mgba.nro on your SD card.
3. Open the homebrew menu on the Switch and launch mGBA.

To copy over FTP, open your FTP app on the Switch (ftpd, DBI, or similar). It
shows an address to connect to, something like 192.168.1.100 on port 5000. Open
that address in your computer's file manager or an FTP client, then drop
mgba.nro into the /switch folder on the SD card. Your address and port will be
different, so use the ones your FTP app shows. You can also take the SD card
out and copy it on a computer.

## ROMs

Put your ROM files anywhere on the SD card. A /roms folder at the root works
well. In mGBA, browse with the d pad and press A to open a ROM.

Only use ROMs of games you own. Do not use this for piracy.

## Controls

* D pad is the GBA d pad
* A is GBA A
* B is GBA B
* L and R are the shoulder buttons
* Plus is Start
* Minus is Select
* X opens the menu

## Menu

Press X during a game to open the menu. From there you can save state, load
state, open Configure, use cheats, or exit back to the file browser.

Screen mode lives in Configure and has three options. Cycle them with A or
left and right, then pick Save at the bottom.

* Stretched fills the whole screen. This is the default.
* Aspect ratio fit keeps the GBA shape with bars on the sides.
* Pixel accurate uses integer scaling for the sharpest picture.

## Build from source

You do not need to build it. Grab the prebuilt mgba.nro from the releases.

If you want to build it anyway, you need Docker. Run:

    tools/setup.sh
    tools/build.sh

The output lands at dist/mgba.nro.

## Credits

* mGBA by Jeffrey Pfau and the mGBA contributors, https://github.com/mgba-emu/mgba
* kaiHEN by kurumuz and ouncebrew, https://github.com/ouncebrew/kaihen
* civ7-fs-kaihen by s8n, https://github.com/s8n/civ7-fs-kaihen
* ounce-devkit, libounce and OunceVK by ouncebrew, https://github.com/ouncebrew/ounce-devkit
* moonlight-nx2 by Azkali, https://gitlab.com/Azkali/moonlight-nx2

## License

The files in this repo are MIT. Each upstream project keeps its own license
(mGBA is MPL 2.0, kaiHEN is GPL 2.0, and so on).

Made with help from LLMs. If you don't trust it, don't use it.
