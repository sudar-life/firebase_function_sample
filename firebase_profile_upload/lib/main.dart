import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_profile_upload/src/controller/authentication_controller.dart';
import 'package:firebase_profile_upload/src/controller/home_controller.dart';
import 'package:firebase_profile_upload/src/root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: BindingsBuilder(() {
        Get.put(AuthenticationController());
        Get.put(HomeController());
      }),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Root(),
    );
  }
}
