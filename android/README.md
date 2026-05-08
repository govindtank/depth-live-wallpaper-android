# Depth Live Wallpaper - Android Edition

A stunning live wallpaper app for Android with parallax depth effects, animated wallpapers, and a built-in editor.

## 🎨 Features

- **Depth Parallax Effects:** Multiple layers move at different speeds when you tilt your device
- **Live Clock Overlay:** Digital clock in Orbitron font that syncs with the time
- **Wallpaper Editor:** Create custom depth wallpapers with 5-layer composition
- **Smooth Animations:** Fluid movement synchronized to gyroscope data
- **Material Design UI:** Beautiful, modern interface

## 📱 Supported Devices

- Android 6.0 (API level 23) and above
- Android One devices
- Xiaomi, OnePlus, Pixel, Samsung Galaxy

## 🛠️ Tech Stack

- **Flutter** - Cross-platform UI framework
- **Android Wallpaper API** - Live wallpaper service
- **Gyroscope Sensor** - For parallax depth effects
- **Dart** - Programming language

## 📁 Project Structure

```
android/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── screens/                  # Gallery, Editor, Settings
│   └── widgets/                  # Reusable components
├── android/                      # Android native config
│   └── app/src/main/AndroidManifest.xml
└── assets/                       # Images and resources
```

## 🎨 Pre-designed Wallpapers

1. **Sunrise Parallax** - Mountain landscape with parallax sun movement
2. **Forest Depth** - Animated forest with birds flying overhead
3. **Ocean Waves** - Dynamic wave patterns with depth layers
4. **Space Stars** - Galaxy animation with planetary effects
5. **City Skyline** - Tokyo-style cityscape at night
6. **Sunset Mountain** - Golden hour mountain silhouette

## 🎮 How It Works

1. **Gallery Tab:** Browse available wallpapers
2. **Editor Tab:** Create custom wallpapers (3-step process):
   - Select background image
   - Add depth layers (adjust offset and opacity)
   - Configure clock overlay
3. **Settings Tab:** Customize animations and performance
4. **Profile Tab:** Account settings
5. **About Tab:** App info and credits

## 🔧 Installation

### From Debug APK

1. Transfer `deep_live_wallpaper_debug.apk` to your Android device
2. Enable "Install from Unknown Sources" in Settings
3. Open the APK file and install
4. Go to Settings > Wallpapers > Live & Motion
5. Select this app and choose a wallpaper

### From GitHub

```bash
git clone https://github.com/govindtank/depth-live-wallpaper-android.git
cd depth-live-wallpaper-android/android
flutter pub get
flutter run
```

## 🚀 Development

### Prerequisites

- Android Studio with Flutter SDK
- Minimum API level 23
- NDK >= 21
- CMake >= 3.6

### Run on Device

```bash
cd android
flutter devices
flutter pub get
flutter run
```

## 📊 Performance Optimization

The app uses the following optimizations:

- **Image Decoding:** Pre-loaded at appropriate resolutions
- **Shader Optimization:** Efficient parallax calculations
- **Memory Management:** Proper disposal of wallpaper resources
- **Battery Efficiency:** Adaptive animation FPS based on device performance

## ⚙️ Permissions Required

- `WRITE_SETTINGS` - To set live wallpaper
- `ACTIVITY_RECOGNITION` - Optional, for motion tracking
- `RECEIVE_BOOT_COMPLETED` - Auto-start on boot (optional)

## 🎯 Future Enhancements

- [ ] AI-powered depth generation from single photos
- [ ] 3D model support (.obj, .gltf files)
- [ ] Custom animation keyframes
- [ ] Share wallpapers to social media
- [ ] In-app purchases for premium wallpapers
- [ ] Voice assistant integration
- [ ] Dark/Light mode toggle

## 📝 License

MIT License - See LICENSE file for details

## 👨‍💻 Author

**Govind Tank**  
[https://github.com/govindtank](https://github.com/govindtank)

---

**Note:** This Android-only version uses Flutter with standard image processing. The iOS/Kotlin Multiplatform versions are in separate repositories.
