import 'package:flutter/material.dart';
import 'confirm_screen.dart';
import 'widgets/title_widget.dart';
import 'widgets/input_widget.dart';
import 'widgets/button_widget.dart';
import 'widgets/back_button_appbar.dart';

class CreatePasswordScreen extends StatefulWidget {
  final String email;
  final String code;
  CreatePasswordScreen({required this.email, required this.code});

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? errorText;

  void handleNext() {
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        errorText = 'Passwords do not match.';
      });
      return;
    }
    setState(() {
      errorText = null;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmScreen(
          email: widget.email,
          code: widget.code,
          password: passwordController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackButtonAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleWidget('Create New Password'),
                Text(
                  'Your new password must be different form previously used password',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      InputWidget('Password', passwordController, obscureText: true),
                      InputWidget('Confirm Password', confirmPasswordController, obscureText: true),
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
