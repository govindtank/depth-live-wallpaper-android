import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const DepthLiveWallpaperApp());
}

class DepthLiveWallpaperApp extends StatefulWidget {
  const DepthLiveWallpaperApp({super.key});

  @override
  State<DepthLiveWallpaperApp> createState() => _DepthLiveWallpaperAppState();
}

class _DepthLiveWallpaperAppState extends State<DepthLiveWallpaperApp> with WidgetsBindingObserver {
  StreamSubscription? wallpaperStream;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startWallpaperMonitoring();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      startWallpaperMonitoring();
    } else if (state == AppLifecycleState.paused) {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    wallpaperStream?.cancel();
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> startWallpaperMonitoring() async {
    await FlutterWallpaperService.start();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Depth Live Wallpaper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    print('Device metrics changed');
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? wallpaperPath;
  bool isWallpaperActive = false;

  Future<void> loadWallpaper() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      const path = 'wallpaper.jpg';
      wallpaperPath = '${directory.path}/$path';
      setState(() {});
    } catch (e) {
      print('Error loading wallpaper: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depth Live Wallpaper'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wallpaper,
              size: 100,
              color: Colors.white70,
            ),
            const SizedBox(height: 20),
            Text(
              'Depth Live Wallpaper App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            if (wallpaperPath != null)
              Image.file(File(wallpaperPath!), fit: BoxFit.cover),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loadWallpaper,
              child: const Text('Load Wallpaper'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    wallpaperStream?.cancel();
    timer?.cancel();
    super.dispose();
  }
}
