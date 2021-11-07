import 'dart:io';

import 'package:firebase_profile_upload/src/controller/authentication_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  Future<XFile?> _pickImage() async {
    try {
      return ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 100);
    } catch (e) {
      return null;
    }
  }

  UploadTask? _upload(String? uid, XFile file) {
    if (uid == null) return null;
    var ref = FirebaseStorage.instance
        .ref()
        .child('user')
        .child(uid)
        .child('/profile.jpg');
    return ref.putFile(File(file.path));
  }

  void changeThumbnail(String? uid) async {
    var file = await _pickImage();
    if (file == null) return;
    var task = _upload(uid, file);
    if (task == null) return;
    task.snapshotEvents.listen((event) async {
      if (event.bytesTransferred == event.totalBytes) {
        var thumbnailDownloadUrl = await downloadUrl(uid!);
        AuthenticationController.to.updateImageUrl(thumbnailDownloadUrl);
      }
    });
  }

  Future<String> downloadUrl(String uid) async {
    return await FirebaseStorage.instance
        .ref('user/$uid/thumb_profile.jpg')
        .getDownloadURL();
  }
}
