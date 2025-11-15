import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _themeColor = Colors.blue;
  final List<Color> _colors = [Colors.blue, Colors.red, Colors.green, Colors.purple];

  @override
  void initState() {
    super.initState();
    _loadThemeColor();
  }

  Future<void> _loadThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt('themeColor');
    if (colorValue != null) {
      setState(() {
        _themeColor = Color(colorValue);
      });
    }
  }

  Future<void> _saveThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeColor', color.value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: _themeColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(_themeColor.value, {
            50: _themeColor,
            100: _themeColor,
            200: _themeColor,
            300: _themeColor,
            400: _themeColor,
            500: _themeColor,
            600: _themeColor,
            700: _themeColor,
            800: _themeColor,
            900: _themeColor,
          }),
        ),
        useMaterial3: true,
      ),
      home: ThemeScreen(
        colors: _colors,
        themeColor: _themeColor, // truyền màu hiện tại
        onColorSelected: (color) {
          setState(() {
            _themeColor = color;
          });
          _saveThemeColor(color);
        },
      ),
    );
  }
}

class ThemeScreen extends StatelessWidget {
  final List<Color> colors;
  final Color themeColor; // thêm property này
  final Function(Color) onColorSelected;

  const ThemeScreen({
    super.key,
    required this.colors,
    required this.themeColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn Chủ Đề'),
        backgroundColor: themeColor,
      ),
      body: Container(
        color: themeColor.withOpacity(0.2), // body đổi màu nhạt hơn
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chọn màu chủ đề:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: colors.map((color) {
                return ElevatedButton(
                  onPressed: () => onColorSelected(color),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    fixedSize: const Size(60, 60),
                    shape: const CircleBorder(),
                  ),
                  child: const SizedBox.shrink(),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
