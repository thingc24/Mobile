import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in failed: $e')),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(top: 50 , bottom: 50, left: 30, right: 30),
              decoration: BoxDecoration(
                color: Color(0xffD5EDFF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xffD5EDFF),
                  width: 2,
                ),
              ),
              child: Image.asset('assets/logo-uth.png', height: 100),
            ),
            const SizedBox(height: 20),
            const Text(
              'SmartTasks',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF007BFF),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'A simple and efficient to-do app',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF007BFF),
              ),
            ),
            const Spacer(),
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ready to explore? Log in to get started.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Image.asset('assets/logo-google.png', height:20),
              label: const Text('SIGN IN WITH GOOGLE', style: TextStyle(color: Colors.black)),
              onPressed: () async {
                final user = await signInWithGoogle(context);
                if (user != null) {
                  Navigator.pushNamed(
                    context,
                    '/profile',
                    arguments: {
                      'name': user.user?.displayName ?? '',
                      'email': user.user?.email ?? '',
                      'avatarUrl': user.user?.photoURL ?? '',
                      'dateOfBirth': '',
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffD5EDFF),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xffD5EDFF)),
                ),
              ),
            ),
            const Spacer(),
            const Text('© UTHSmartTasks', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
