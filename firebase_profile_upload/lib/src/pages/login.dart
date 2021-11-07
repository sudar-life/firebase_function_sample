import 'package:firebase_profile_upload/src/controller/authentication_controller.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: AuthenticationController.to.signInWithGoogle,
                child: const Text('구글로그인'))
          ],
        ),
      ),
    );
  }
}
