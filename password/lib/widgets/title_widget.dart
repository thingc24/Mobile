import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/Logo-UTH.png', height: 100),
        SizedBox(height: 20),
        Text('SmartTasks', style: TextStyle(fontSize: 24, color: Colors.blue)),
        SizedBox(height: 10),
        Text(title, style: TextStyle(fontSize: 20)),
        SizedBox(height: 20),
      ],
    );
  }
}
