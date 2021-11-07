import 'package:firebase_profile_upload/src/controller/authentication_controller.dart';
import 'package:firebase_profile_upload/src/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          GestureDetector(
            onTap: AuthenticationController.to.logout,
            child: const Center(
              child: Text('로그아웃'),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child:
                  GetBuilder<AuthenticationController>(builder: (controller) {
                return Column(
                  children: [
                    Image.network(
                      controller.user!.thumbnail ??
                          'https://herrmans.eu/wp-content/uploads/2019/01/765-default-avatar.png',
                      width: 200,
                    ),
                    Text('환영합니다 ${controller.user!.displayName}님'),
                  ],
                );
              }),
            ),
            Expanded(
                child: Center(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        controller.changeThumbnail(
                            AuthenticationController.to.user!.uid);
                      },
                      child: const Text('이미지 등록'))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
