# Keyboard Overlay

> A macOS menubar app that overlays a transparent keyboard on the screen.

<p align="center"><img src="KeyboardOverlay/Assets.xcassets/AppIcon.appiconset/Keyboard Overlay-256@1x.png" width="128"></p>

<p align="center"><img src="Images/Screen Recording.gif"></p>

## Features

- Created for those who are learning a new language or need to type on a keyboard that has a different layout;
- Supports any keyboard layout standard available on macOS;
- Displays special characters that can be typed by pressing key combinations with modifier keys;
- Allows you to set a keyboard shortcut to hide and show the keyboard overlay;
- It can be displayed over any application, even when it is in full screen;
- Does not prevent mouse clicks on elements shown below the keyboard overlay.

## Requirements

- Requires macOS 14 Sonoma or later.
- Requires accessibility permission in the Privacy & Security section of the System Settings app to be able to detect keyboard events.

## Building

This project uses GitHub Actions to automatically build binaries:

### Automated Builds
- **Push to main**: Automatically builds Debug and Release versions
- **Pull Requests**: Builds and tests changes  
- **Tagged Releases**: Creates release with DMG and ZIP files

### Manual Building
To build locally with Xcode:
```bash
# Build Debug version
xcodebuild -project KeyboardOverlay.xcodeproj -scheme "Keyboard Overlay" -configuration Debug build

# Build Release version  
xcodebuild -project KeyboardOverlay.xcodeproj -scheme "Keyboard Overlay" -configuration Release build

# Create archive
xcodebuild -project KeyboardOverlay.xcodeproj -scheme "Keyboard Overlay" -configuration Release archive -archivePath KeyboardOverlay.xcarchive
```

### Artifacts
The GitHub Actions workflow produces:
- Debug build (`.app` bundle)
- Release build (`.app` bundle) 
- Archive (`.xcarchive`)
- DMG installer
- ZIP archive

## Contributing

If you find this app useful and want to help improve it, feel free to suggest new features or fork the repository. Pull requests are welcome.

## License
[GNU General Public License](LICENSE)