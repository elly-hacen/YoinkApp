<p align="center">
  <img src="Yoink.png" width="128" height="128" alt="Yoink logo">
</p>

<h1 align="center">Yoink</h1>

<p align="center">
  Cut & move files in macOS Finder — right from the context menu.
</p>

---

## Why?

macOS already lets you move files — but the workflow is buried behind a keyboard shortcut most people don't know:

1. Select a file, press **Cmd+C** to copy
2. Navigate to the destination
3. Press **Cmd+Option+V** to move (instead of paste)

That's it. That's the "cut" macOS has always had. But there's no right-click menu option for it, and the **Option** key trick is completely hidden from the UI. Most users don't even know it exists.

**Yoink brings this into the context menu** — no keyboard shortcuts to memorize, no hidden modifier keys. Just right-click:

- **Yoink** — grab/cut the selected file
- **Yank Here** — move it to the current folder

The file is moved, not copied. The original is removed after a successful move.

## Install

1. Download **Yoink.dmg** from the [latest release](../../releases/latest)
2. Open the DMG and drag **YoinkApp** into **Applications**
3. Open **YoinkApp** once from Applications
   > Since the app isn't notarized, macOS will block it. Right-click the app and select **Open**, then click **Open** in the dialog.

## Enable the Finder Extension

After installing, you need to enable the Finder extension manually:

1. Open **System Settings**
2. Go to **General** > **Login Items & Extensions**
3. Click **Extensions** at the bottom
4. Select **Finder Extensions**
5. Toggle **YoinkFinder** on

## Usage

1. Right-click any file in Finder → select **Yoink** (scissors icon)
2. Navigate to the destination folder
3. Right-click inside the folder → select **Yank Here** (arrow icon)
4. Done — the file has been moved

> **Yank Here** only appears in the menu after you've Yoinked a file.

## Build from Source

Requires Xcode and macOS.

1. Clone the repository
   ```
   git clone https://github.com/elly-hacen/YoinkApp.git
   ```
2. Open `YoinkApp.xcodeproj` in Xcode
3. Select the **YoinkApp** scheme and build (Cmd+B)
4. Run the app, then enable the extension as described above

## How It Works

Yoink is a [Finder Sync Extension](https://developer.apple.com/documentation/findersync) built in Swift. It consists of:

- **YoinkApp** — a minimal host app (required by Apple to deliver the extension)
- **YoinkFinder** — the Finder extension that adds context menu items

The extension uses `UserDefaults` to store the path of the grabbed file and `FileManager` to perform the move operation (copy + delete).

