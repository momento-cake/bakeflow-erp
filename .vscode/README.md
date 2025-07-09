# VS Code Debug Configuration

This directory contains VS Code configuration files for debugging the BakeFlow ERP Flutter web application.

## 🚀 Quick Start

1. **Open in VS Code**: `code .` from project root
2. **Install Extensions**: Accept the recommended extensions prompt
3. **Select Configuration**: Go to Run & Debug panel (⇧⌘D)
4. **Choose Browser**: Select your preferred browser from the dropdown
5. **Start Debugging**: Press F5 or click the play button

## 🔧 Available Configurations

### Web Debugging
- **🌐 Debug Web (Default Browser)** - Uses system default browser
- **🏹 Debug with Arc Browser** - Specifically for Arc browser
- **🟢 Debug with Chrome** - Google Chrome debugging
- **🔵 Debug with Edge** - Microsoft Edge debugging

### Hot Reload
- **🔄 Hot Reload (Default)** - Hot reload with default browser
- **🔄 Hot Reload (Arc)** - Hot reload with Arc browser

### Other Platforms
- **💻 macOS Desktop** - Native macOS app debugging

## 🐛 Troubleshooting

### "Cannot launch without an active device" Error

This error occurs when Flutter can't detect web devices. Try these solutions:

1. **Enable Web Support**:
   ```bash
   fvm flutter config --enable-web
   ```

2. **Clean and Rebuild**:
   ```bash
   fvm flutter clean
   fvm flutter pub get
   ```

3. **Manual Browser Launch**:
   If debugging fails, you can manually run:
   ```bash
   fvm flutter run -d web-server --web-port=4000 --web-hostname=localhost
   ```
   Then open `http://localhost:4000` in your browser.

4. **Check Browser Paths**:
   Verify your browser is installed at the expected path:
   - Arc: `/Applications/Arc.app/Contents/MacOS/Arc`
   - Chrome: `/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`
   - Edge: `/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge`

### Web Server Not Starting

If the web server configuration fails:

1. **Use Terminal**:
   ```bash
   fvm flutter run -d web-server --web-port=4000
   ```

2. **Try Different Port**:
   Change `4000` to `3000` or `8080` in launch.json

3. **Check Firewall**:
   Ensure localhost connections are allowed

### Flutter Doctor Issues

Run `fvm flutter doctor` to check for issues:
```bash
fvm flutter doctor -v
```

Common fixes:
- Chrome executable path issues
- Web support not enabled
- FVM Flutter version mismatches

## 🎯 Browser-Specific Notes

### Arc Browser
- Uses Chrome engine, should work with Chrome debugging
- Path: `/Applications/Arc.app/Contents/MacOS/Arc`
- Fallback: Use "Debug Web (Default Browser)" if Arc-specific config fails

### Chrome
- Best debugging experience with Flutter
- DevTools integration is most stable
- Recommended for development

### Edge
- Good alternative to Chrome
- Similar debugging capabilities
- Uses Chromium engine

## 📱 Mobile Development

For mobile debugging, use:
- **iOS**: Requires Xcode and iOS Simulator
- **Android**: Requires Android Studio and emulator/device

## 🔗 Useful Commands

```bash
# List available devices
fvm flutter devices

# Check Flutter configuration
fvm flutter config

# Run with specific browser
CHROME_EXECUTABLE="/Applications/Arc.app/Contents/MacOS/Arc" fvm flutter run -d web-server

# Hot reload during development
fvm flutter run -d web-server --hot
```

## 🆘 Still Having Issues?

1. **Check FVM Setup**:
   ```bash
   fvm --version
   fvm flutter --version
   ```

2. **Restart VS Code**: Sometimes extensions need a restart
3. **Check Terminal**: Look for detailed error messages
4. **Use Task Runner**: Try the predefined tasks in tasks.json

## 📚 Resources

- [Flutter Web Documentation](https://flutter.dev/web)
- [VS Code Flutter Extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- [Firebase Web Setup](https://firebase.flutter.dev/docs/overview/)