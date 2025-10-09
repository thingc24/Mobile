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
      home: ThucHanh02(),
    );
  }
}

class ThucHanh02 extends StatefulWidget {
  const ThucHanh02({super.key});

  @override
  State<ThucHanh02> createState() => _ThucHanh02State();
}

class _ThucHanh02State extends State<ThucHanh02> {
  final TextEditingController _emailController = TextEditingController();
  String? message;
  Color? messageColor;

  void _checkEmail() {
    FocusScope.of(context).unfocus();
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        message = "Email không hợp lệ";
        messageColor = Colors.red;
      });
    } else if (!email.contains('@')) {
      setState(() {
        message = "Email không đúng định dạng";
        messageColor = Colors.red;
      });
    } else {
      setState(() {
        message = "Bạn đã nhập email hợp lệ";
        messageColor = Colors.green;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Thực hành 02",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Ô nhập email
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: "Email",
                  ),
                ),

                const SizedBox(height: 10),

                // Thông báo lỗi hoặc thành công
                if (message != null)
                  Text(
                    message!,
                    style: TextStyle(
                      color: messageColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                const SizedBox(height: 20),

                // Nút kiểm tra
                ElevatedButton(
                  onPressed: _checkEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 120),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Kiểm tra",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
