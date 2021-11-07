import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_profile_upload/src/models/user_model.dart';

class AuthRepository {
  static Future<UserModel?> findUserByUid(String uid) async {
    var users = FirebaseFirestore.instance.collection('users');
    try {
      var user = await users.where('uid', isEqualTo: uid).get();
      if (user.size == 0) return null;
      return UserModel.fromJson(user.docs[0].id, user.docs[0].data());
    } catch (e) {
      return null;
    }
  }

  static Future<String?> signup(UserModel? user) async {
    if (user == null) return null;
    var users = FirebaseFirestore.instance.collection('users');
    var drf = await users.add(user.toMap());
    return drf.id;
  }

  static Future<void> updateUserData(UserModel? user) async {
    if (user == null) return;
    var userCollection = FirebaseFirestore.instance.collection('users');
    await userCollection.doc(user.docId).update(user.toMap());
  }
}
