import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  final PageController pageController;

  OnboardingPage1({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Đổi background thành màu trắng
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, size: 10, color: Colors.blue),
                      SizedBox(width: 4),
                      Icon(Icons.circle, size: 10, color: Colors.grey),
                      SizedBox(width: 4),
                      Icon(Icons.circle, size: 10, color: Colors.grey),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      pageController.jumpToPage(2); // Chuyển đến trang cuối cùng
                    },
                    child: Text(
                      'skip',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Image.asset('assets/images/image1.png', height: 250),
              SizedBox(height: 40),
              Text(
                'Easy Time Management',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'With management based on priority and\ndaily tasks, it will give you convenience in\nmanaging and determining the tasks that\nmust be done first',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}