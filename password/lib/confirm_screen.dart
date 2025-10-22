import 'package:flutter/material.dart';
import 'widgets/title_widget.dart';
import 'widgets/input_widget.dart';
import 'widgets/button_widget.dart';
import 'widgets/back_button_appbar.dart';

class ConfirmScreen extends StatelessWidget {
  final String email;
  final String code;
  final String password;

  ConfirmScreen({required this.email, required this.code, required this.password});

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
                TitleWidget('Confirm'),
                Text(
                  'We are here to help you!',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      InputWidget('Email', TextEditingController(text: email), enabled: false),
                      InputWidget('Code', TextEditingController(text: code), enabled: false),
                      InputWidget('Password', TextEditingController(text: password), obscureText: true, enabled: false),
                      ButtonWidget('Submit', () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Submitted Successfully!')));
                      }),
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
