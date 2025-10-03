import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Nút Back
            Positioned(
              left: width * 0.04,
              top: height * 0.02,
              child: Container(
                padding: EdgeInsets.all(width * 0.015),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  iconSize: width * 0.05,
                  onPressed: () {},
                ),
              ),
            ),

            // Nút Edit
            Positioned(
              right: width * 0.04,
              top: height * 0.02,
              child: Container(
                padding: EdgeInsets.all(width * 0.015),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: Icon(Icons.edit_note),
                  iconSize: width * 0.1,
                  onPressed: () {},
                ),
              ),
            ),

            // Nội dung chính
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: width * 0.2,
                    backgroundImage:const AssetImage('assets/images/avt.jpg'),
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    'Ngọc Thi',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'Đồng Tháp, Việt Nam',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}