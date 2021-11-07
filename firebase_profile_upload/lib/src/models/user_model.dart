class UserModel {
  String? docId;
  String? uid;
  String? thumbnail;
  String? displayName;

  UserModel({
    this.docId,
    this.uid,
    this.thumbnail,
    this.displayName,
  });

  factory UserModel.fromJson(String docId, Map<String, dynamic> json) {
    return UserModel(
      docId: docId,
      uid: json['uid'] != null ? json['uid'] as String : '',
      thumbnail: json['thumbnail'] != null ? json['thumbnail'] as String : '',
      displayName:
          json['display_name'] != null ? json['display_name'] as String : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'thumbnail': thumbnail,
      'display_name': displayName,
    };
  }

  UserModel copyWith({
    String? docId,
    String? uid,
    String? thumbnail,
    String? displayName,
  }) {
    return UserModel(
      docId: docId ?? this.docId,
      uid: uid ?? this.uid,
      thumbnail: thumbnail ?? this.thumbnail,
      displayName: displayName ?? this.displayName,
    );
  }
}
