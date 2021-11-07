import 'package:firebase_profile_upload/src/controller/authentication_controller.dart';
import 'package:firebase_profile_upload/src/pages/home.dart';
import 'package:firebase_profile_upload/src/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(builder: (controller) {
      if (controller.user == null) {
        return const Login();
      } else {
        return const Home();
      }
    });
  }
}
