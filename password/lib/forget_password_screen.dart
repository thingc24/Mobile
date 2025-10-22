import 'package:flutter/material.dart';
import 'verify_code_screen.dart';
import 'widgets/title_widget.dart';
import 'widgets/input_widget.dart';
import 'widgets/button_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  String? errorText;

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]');
    return emailRegex.hasMatch(email);
  }

  void handleNext() {
    final email = emailController.text.trim();
    if (!isValidEmail(email)) {
      setState(() {
        errorText = 'Please enter a valid email address.';
      });
      return;
    }
    setState(() {
      errorText = null;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifyCodeScreen(email: email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleWidget('Forget Password?'),
                Text(
                  'Enter your Email, we will send you a verification code.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      InputWidget('Your Email', emailController),
                      if (errorText != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            errorText!,
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                      ButtonWidget('Next', handleNext),
                    ],
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
