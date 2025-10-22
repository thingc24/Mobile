import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'firstscreen.dart';
import 'secondscreen.dart';
import 'thirdscreen.dart';

void main() {
  runApp(SmartTasksApp());
}

class SmartTasksApp extends StatelessWidget {
  const SmartTasksApp({super.key});
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen()
    );
  }
}
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Đổi background thành màu trắng
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              OnboardingPage1(pageController: _pageController),
              OnboardingPage2(pageController: _pageController),
              OnboardingPage3(pageController: _pageController),
            ],
          ),
        ],
      ),
    );
  }
}