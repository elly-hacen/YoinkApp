import Cocoa
import FinderSync

class FinderSync: FIFinderSync {

    let defaults = UserDefaults.standard
    let clipboardKey = "yoinkClipboardPath"

    override init() {
        super.init()
        FIFinderSyncController.default().directoryURLs = [URL(fileURLWithPath: "/")]
    }

    // Context Menu

    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        let menu = NSMenu(title: "")

        let menuConfig = NSImage.SymbolConfiguration(hierarchicalColor: .labelColor)

        let yoinkItem = NSMenuItem(title: "Yoink", action: #selector(yoink(_:)), keyEquivalent: "")
        yoinkItem.image = NSImage(systemSymbolName: "scissors", accessibilityDescription: "Cut")?
            .withSymbolConfiguration(menuConfig)
        menu.addItem(yoinkItem)

        if defaults.string(forKey: clipboardKey) != nil {
            let yankItem = NSMenuItem(title: "Yank Here", action: #selector(yankHere(_:)), keyEquivalent: "")
            yankItem.image = NSImage(systemSymbolName: "arrow.down.doc", accessibilityDescription: "Move here")?
                .withSymbolConfiguration(menuConfig)
            menu.addItem(yankItem)
        }

        return menu
    }

    // Actions

    @objc func yoink(_ sender: AnyObject?) {
        guard let items = FIFinderSyncController.default().selectedItemURLs(),
              let firstItem = items.first else { return }

        defaults.set(firstItem.path, forKey: clipboardKey)
        NSLog("Yoink: Grabbed %@", firstItem.path)
    }

    @objc func yankHere(_ sender: AnyObject?) {
        guard let sourcePath = defaults.string(forKey: clipboardKey) else { return }
        guard let targetURL = FIFinderSyncController.default().targetedURL() else { return }

        let sourceURL = URL(fileURLWithPath: sourcePath)
        let fileName = sourceURL.lastPathComponent
        let destURL = targetURL.appendingPathComponent(fileName)

        do {
            try FileManager.default.copyItem(at: sourceURL, to: destURL)
            try FileManager.default.removeItem(at: sourceURL)
            defaults.removeObject(forKey: clipboardKey)
            NSLog("Yoink: Yanked %@ to %@", sourcePath, destURL.path)
        } catch {
            NSLog("Yoink: Failed - %@", error.localizedDescription)
        }
    }
}
