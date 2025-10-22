import 'package:flutter/material.dart';
import 'create_password_screen.dart';
import 'widgets/title_widget.dart';
import 'widgets/button_widget.dart';
import 'widgets/back_button_appbar.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;
  VerifyCodeScreen({required this.email});

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final codeController = TextEditingController();
  final List<TextEditingController> digitControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    codeController.dispose();
    for (final c in digitControllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int idx, String value) {
    if (value.length == 1 && idx < 5) {
      focusNodes[idx + 1].requestFocus();
    }
    if (value.isEmpty && idx > 0) {
      focusNodes[idx - 1].requestFocus();
    }
    codeController.text = digitControllers.map((c) => c.text).join();
  }

  Widget _buildCodeInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (idx) {
        return Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: TextField(
            controller: digitControllers[idx],
            focusNode: focusNodes[idx],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) => _onDigitChanged(idx, value),
          ),
        );
      }),
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
                TitleWidget('Verify Code'),
                Text(
                  'Enter the the code we just sent you on your registered Email',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildCodeInput(),
                      SizedBox(height: 20),
                      ButtonWidget('Next', () {
                        codeController.text = digitControllers.map((c) => c.text).join();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreatePasswordScreen(
                              email: widget.email,
                              code: codeController.text,
                            ),
                          ),
                        );
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
