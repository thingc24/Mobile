import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowTextExample(),
    );
  }
}

class ShowTextExample extends StatefulWidget {
  const ShowTextExample({super.key});

  @override
  State<ShowTextExample> createState() => _ShowTextExampleState();
}

class _ShowTextExampleState extends State<ShowTextExample> {
  bool showText = false; // ban đầu chưa hiện

  void _handleClick() {
    setState(() {
      showText = true; // khi bấm nút thì hiện text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My App"),centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showText)
              const Text(
                "Thi",
                style: TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleClick,
              child: const Text("Button"),
            ),
          ],
        ),
      ),
    );
  }
}
