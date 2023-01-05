import 'package:cloud_firestore/cloud_firestore.dart';

class Post_Model {
  String? discreption;
  String? uid;
  String? userProfileUrl;
  String? username;
  String? postUid;
  final dateOfPost;
  String? postPhotoUrl;
  List? like;
  List? share;
  Post_Model(
      {required this.discreption,
      required this.uid,
      required this.userProfileUrl,
      required this.username,
      required this.postUid,
      required this.dateOfPost,
      required this.postPhotoUrl,
      required this.like,
      required this.share});
  // now to store to firebasestore
  Map<String, dynamic> toJson() {
    return {
      "discreption": discreption,
      "uid": uid,
      "userProfileUrl": userProfileUrl,
      "username": username,
      "postUid": postUid,
      "dateOfPost": dateOfPost,
      "postPhotoUrl": postPhotoUrl,
      "like": like,
      "share": share
    };
  }

  static Post_Model fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Post_Model(
        discreption: snap[" discreption"],
        uid: snap["uid"],
        userProfileUrl: snap["userProfileUrl"],
        username: snap["username"],
        postUid: snap["postUid"],
        dateOfPost: snap["dateOfPost"],
        postPhotoUrl: snap["  postPhotoUrl"],
        like: snap["like"],
        share: snap["share"]);
  }
}
