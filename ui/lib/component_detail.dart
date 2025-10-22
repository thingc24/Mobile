import 'package:flutter/material.dart';

class ComponentDetail extends StatelessWidget {
  final Map<String, dynamic> component;

  const ComponentDetail({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(component['title'])),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: component['widget'],
      ),
    );
  }
}