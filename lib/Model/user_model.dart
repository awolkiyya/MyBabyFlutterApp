import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? username;
  String? email;
  String? profileUrl;
  String? uid;
  User(
      {required this.username,
      required this.email,
      required this.profileUrl,
      required this.uid});
  // to store to the firebase as documents change this object to json
  Map<String, dynamic> tojson() {
    return {
      "username": username,
      "email": email,
      "profilrUrl": profileUrl,
      "uid": uid
    };
  }

  // this is the method used to retrive the json data from the documents
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        username: snapshot['username'],
        email: snapshot['email'],
        profileUrl: snapshot['profileUrl'],
        uid: snapshot['uid']);
  }
}
