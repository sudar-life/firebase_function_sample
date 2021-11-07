import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_profile_upload/src/models/user_model.dart';
import 'package:firebase_profile_upload/src/repository/auth_repository.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get to => Get.find();
  UserModel? user;

  @override
  void onInit() {
    super.onInit();
    _event();
  }

  void _event() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      await login(user);
      update();
    });
  }

  Future<void> login(User? userAuth) async {
    if (userAuth == null) return;
    user = await AuthRepository.findUserByUid(userAuth.uid);
    if (user == null) {
      user = UserModel(
        uid: userAuth.uid,
        displayName: userAuth.displayName,
        thumbnail: userAuth.photoURL,
      );
      var id = await AuthRepository.signup(user);
      user = user!.copyWith(docId: id);
      if (id == null) logout();
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    user = null;
    update();
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void updateImageUrl(String thumbnailDownloadUrl) async {
    user = user!.copyWith(thumbnail: thumbnailDownloadUrl);
    await AuthRepository.updateUserData(user);
    update();
  }
}
