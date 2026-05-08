import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DepthLiveWallpaperApp());
}

class DepthLiveWallpaperApp extends StatelessWidget {
  const DepthLiveWallpaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Depth Live Wallpaper',
      debugShowCheckedModeBanner: false, // Removed const as it's not allowed here
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: GalleryScreen(),
    );
  }
}

/// Sample depth wallpaper layers
class DepthWallpaper {
  final String id;
  final String name;
  final List<DepthLayer> layers;
  final ClockConfig clockConfig;

  DepthWallpaper({
    required this.id,
    required this.name,
    required this.layers,
    required this.clockConfig,
  });
}

class DepthLayer {
  final String imagePath;
  final double depthFactor;
  final double offsetX;
  final double offsetY;
  final double opacity;

  DepthLayer({
    required this.imagePath,
    this.depthFactor = 0.5,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
    this.opacity = 1.0,
  });
}

class ClockConfig {
  final String type; // 'digital', 'analog', 'none'
  final String fontFamily;
  final String color;
  final double size;
  final String format;
  final bool showDate;

  const ClockConfig({
    this.type = 'digital',
    this.fontFamily = 'Orbitron',
    this.color = '#06B6D4',
    this.size = 1.0,
    this.format = 'HH:mm',
    this.showDate = false,
  });
}

/// Gallery Screen - Tab 1: Browse wallpapers
class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<DepthWallpaper> wallpapers = [
  DepthWallpaper(
    id: 'sunrise_parallax',
    name: 'Sunrise Parallax',
    layers: [
      DepthLayer(imagePath: 'assets/images/background.png', depthFactor: 0.2, opacity: 1.0),
      DepthLayer(imagePath: 'assets/images/mountains.png', depthFactor: 0.7, opacity: 0.9),
      DepthLayer(imagePath: 'assets/images/sun.png', depthFactor: 1.0, opacity: 0.8),
    ],
    clockConfig: ClockConfig(type: 'digital', format: 'HH:mm'),
  ),
    DepthWallpaper(
      id: 'forest_depth',
      name: 'Forest Depth',
      layers: [
        DepthLayer(imagePath: 'assets/images/forest_bg.png', depthFactor: 0.1, opacity: 1.0),
        DepthLayer(imagePath: 'assets/images/trees.png', depthFactor: 0.5, opacity: 0.9),
        DepthLayer(imagePath: 'assets/images/birds.png', depthFactor: 1.0, opacity: 0.7),
      ],
      clockConfig: ClockConfig(type: 'digital', color: '#22C55E'),
    ),
    DepthWallpaper(
      id: 'ocean_waves',
      name: 'Ocean Waves',
      layers: [
        DepthLayer(imagePath: 'assets/images/ocean_bg.png', depthFactor: 0.15, opacity: 1.0),
        DepthLayer(imagePath: 'assets/images/waves.png', depthFactor: 0.8, opacity: 0.95),
        DepthLayer(imagePath: 'assets/images/seafoam.png', depthFactor: 1.0, opacity: 0.85),
      ],
      clockConfig: ClockConfig(type: 'digital', color: '#7C3AED'),
    ),
    DepthWallpaper(
      id: 'space_stars',
      name: 'Space Stars',
      layers: [
        DepthLayer(imagePath: 'assets/images/space_bg.png', depthFactor: 0.1, opacity: 1.0),
        DepthLayer(imagePath: 'assets/images/galaxy.png', depthFactor: 0.6, opacity: 0.9),
        DepthLayer(imagePath: 'assets/images/planet.png', depthFactor: 1.0, opacity: 0.8),
      ],
      clockConfig: ClockConfig(type: 'digital', color: '#EF4444'),
    ),
    DepthWallpaper(
      id: 'city_skyline',
      name: 'City Skyline',
      layers: [
        DepthLayer(imagePath: 'assets/images/city_bg.png', depthFactor: 0.2, opacity: 1.0),
        DepthLayer(imagePath: 'assets/images/buildings.png', depthFactor: 0.7, opacity: 0.95),
        DepthLayer(imagePath: 'assets/images/tokyo_tower.png', depthFactor: 1.0, opacity: 0.8),
      ],
      clockConfig: ClockConfig(type: 'digital', color: '#F59E0B'),
    ),
    DepthWallpaper(
      id: 'sunset_mountain',
      name: 'Sunset Mountain',
      layers: [
        DepthLayer(imagePath: 'assets/images/mountain_bg.png', depthFactor: 0.2, opacity: 1.0),
        DepthLayer(imagePath: 'assets/images/sunset_sky.png', depthFactor: 0.5, opacity: 0.9),
        DepthLayer(imagePath: 'assets/images/clover.png', depthFactor: 1.0, opacity: 0.8),
      ],
      clockConfig: ClockConfig(type: 'digital', color: '#EC4899'),
    ),
  ];

  void _openEditor() {
    // TODO: Navigate to editor screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditorScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openEditor,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Horizontal carousel of wallpaper cards
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: wallpapers.asMap().entries.map((entry) {
                final index = entry.key;
                final wallpaper = entry.value;
                return _WallpaperCard(
                  wallpaper: wallpaper,
                  onTap: () => _openPreview(index),
                  onLongPress: () => _showContextMenu(context),
                  key: ValueKey(wallpaper.id),
                );
              }).toList(),
            ),
          ),

          // Preview area at top showing the currently selected wallpaper
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: _buildPreviewArea(),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewArea() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      color: Colors.black,
      child: Stack(
        children: [
          // Placeholder - in real app this would show live parallax preview
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.layers, size: 100, color: Colors.grey[700]),
                const SizedBox(height: 16),
                Text(
                  'Preview',
                  style: TextStyle(color: Colors.grey[400], fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openPreview(int index) {
    // TODO: Show full-screen live wallpaper preview with parallax
    final String name = wallpapers[index].name;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening preview for $name'),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('Apply as Wallpaper'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wallpaper applied to home screen')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Duplicate'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _WallpaperCard extends StatelessWidget {
  final DepthWallpaper wallpaper;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _WallpaperCard({
    super.key,
    required this.wallpaper,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.image, color: Colors.grey[400]),
          ),
          title: Text(
            wallpaper.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text('${wallpaper.layers.length} layers'),
          trailing: Badge(
            label: const Text('Tap to Preview'),
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}

/// Tab 2: Editor Screen - Create new depth wallpapers
class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _complete() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Wallpaper created! It will appear in Gallery.')),
    );
    Navigator.pop(context);
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editor - Step ${_currentStep + 1}'),
        actions: [
          if (_currentStep == 0)
            IconButton(icon: const Icon(Icons.camera_alt), onPressed: () {}),
          if (_currentStep == 1)
            IconButton(icon: const Icon(Icons.photo), onPressed: () {}),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentStep = index),
        itemCount: 3, // 3 steps
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return Step1BackgroundImage();
            case 1:
              return Step2AddLayers();
            case 2:
              return Step3ClockConfig();
            default:
              return Container();
          }
        },
      ),
    );
  }
}

class Step1BackgroundImage extends StatelessWidget {
  const Step1BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 1: Background Image',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Select the background image for your depth wallpaper. The app will automatically create blur-based pseudo-depth layers from this single image.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
          ),
          const Divider(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
            ),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[700]!),
                ),
                child: Icon(Icons.image, size: 48, color: Colors.grey[600]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Step2AddLayers extends StatelessWidget {
  const Step2AddLayers({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 2: Add Depth Layers',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Add up to 5 additional layers. Each layer has its own depth factor (0.1-1.0) that determines how much it moves with the gyroscope.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
          ),
          const Divider(height: 32),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.layers, color: Colors.grey[400]),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Layer 1', style: TextStyle(fontWeight: FontWeight.w600)),
                        Slider(
                          value: 0.5,
                          min: 0.1,
                          max: 1.0,
                          divisions: 9,
                          onChanged: (value) {},
                        ),
                        const Text('Depth Factor', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Step3ClockConfig extends StatelessWidget {
  const Step3ClockConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 3: Clock Configuration',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Configure your live clock overlay:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
          ),
          const Divider(height: 32),
          RadioListTile<String>(
            title: const Text('Digital Clock'),
            value: 'digital',
            groupValue: 'digital',
            onChanged: (value) {},
            subtitle: Text('Orbitron font, cyan color, HH:mm format'),
          ),
          RadioListTile<String>(
            title: const Text('Analog Clock'),
            value: 'analog',
            groupValue: 'analog',
            onChanged: (value) {},
            subtitle: Text('Hour and minute hands with date'),
          ),
          RadioListTile<String>(
            title: const Text('No Clock'),
            value: 'none',
            groupValue: 'none',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
