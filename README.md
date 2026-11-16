# SandFly Scripts

Scripts for the [SandFly](https://github.com/aaron-gh/SandFly) screen reader for Android. The scripts speak and show their menus in Ukrainian.

## How to install

**Recommended: add this repository as a script source.** Scripts can then be installed straight from SandFly, and they update automatically.

1. SandFly settings > Apps > Scripts > Script sources > Add source.
2. Enter: `github.com/shpak1704/sandfly-scripts`
3. Open the source, choose a script and confirm the install.

To get updates without being asked, turn on **Update scripts automatically** on the Scripts screen.

**Or manually:** download a `.lua` file below, then go to Scripts > Import script.

These scripts aren't signed by SandFly, so the install dialog says **Not signed by SandFly**. That's expected for scripts that don't come from SandFly's author.

## Scripts

| Script | App | What it does |
| --- | --- | --- |
| [Timer and stopwatch](timer-stopwatch.lua) | Any | Countdown timers and stopwatches with spoken alerts: one-gesture start, ready-made presets, pause, several at once. Works with the screen off. |
| [EasyWay: board number and map](easyway-bort.lua) | EasyWay | Speaks each vehicle's board number; every vehicle on a stop screen reads in two swipes; the map no longer gets in the way. |
| [Auto PIN](auto-pin.lua) | Lock screen | Enters your PIN on the lock screen from the SandFly menu, or automatically when the lock screen appears. |

### Auto PIN: unlocking right after a restart

Right after the phone restarts, SandFly doesn't load scripts yet, but macros already work. To unlock at that moment, use a macro. There are two ways to get one.

**On the phone, no computer needed:**

1. Download [auto-pin-macro-example.json](auto-pin-macro-example.json) to the phone.
2. SandFly settings > Macros > import from file > choose the file.
3. Open the imported macro **PIN**. It types the example PIN `1234`. Each of its four tap steps looks for a button like `^1([ ,]+\S{1,5}){0,2}$`: change only the digit after `^` to the matching digit of your PIN, and leave the rest as it is. The rest makes sure the macro taps the PIN button `1` and not the clock or a date. For a 6-digit PIN, add two more tap steps the same way, with **Regular expression** turned on.
4. Assign a gesture to the macro: SandFly settings > Commands > Macros > **PIN**.

**On a computer with PowerShell 7:** [make-pin-macro.ps1](make-pin-macro.ps1) makes the macro file for you.

1. Put `make-pin-macro.ps1` in any folder, open PowerShell there and run it with your PIN: `pwsh -File make-pin-macro.ps1 123456`
2. The file `auto-pin-macro.json` appears next to it. Copy it to the phone and import it as above, then assign a gesture to the macro **Ввести PIN-код** (Enter PIN).

If the PIN pad isn't shown yet, either macro asks you to swipe up with two fingers: it can't swipe by itself.

A macro file with your own PIN stores it as plain text. Don't share it with anyone.

## Feedback

If something sounds wrong or doesn't work, open an [issue](https://github.com/shpak1704/sandfly-scripts/issues), ideally with the screen tree attached (SandFly menu: Copy screen tree).

License: [Apache 2.0](LICENSE).
