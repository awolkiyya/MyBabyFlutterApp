import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Model/post_model.dart';
import 'package:instagram_app/Model/user_model.dart' as model;
import 'package:instagram_app/Utils/constant.dart';
import 'package:uuid/uuid.dart';

class Operation extends GetxController {
  RxBool isposting = false.obs;
  final Rx<List<Post_Model>> _postList = Rx<List<Post_Model>>([]);

  List<Post_Model> get postList => _postList.value;

  @override
  void onInit() {
    super.onInit();
    _postList.bindStream(Utils()
        .firebaseFirestore
        .collection('posts')
        .snapshots()
        .map((QuerySnapshot query) {
      print(query);
      List<Post_Model> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Post_Model.fromJson(element),
        );
      }
      return retVal;
    }));
  }

  Future<String> _uploadPostToStorage(String postid, File? image) async {
    Reference ref =
        Utils().firebaseStorage.ref().child('postPhotos').child(postid);

    UploadTask uploadTask = ref.putFile(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  posting(model.User? user, String comment, File? postedImage) async {
    String postId = const Uuid().v1();
    String postUrl = await _uploadPostToStorage(postId, postedImage);
    print(postUrl);
    Post_Model post_model = new Post_Model(
        discreption: comment,
        uid: user!.uid,
        userProfileUrl: user.profileUrl,
        username: user.username,
        postUid: postId,
        dateOfPost: DateTime.now(),
        postPhotoUrl: postUrl,
        like: [],
        share: []);
    try {
      await Utils()
          .firebaseFirestore
          .collection("posts")
          .doc(postId)
          .set(post_model.toJson());
    } catch (e) {
      Get.snackbar("", "${e}");
    }
  }

  bool _isposting() {
    if (isposting.value) {
      return true;
    } else {
      return false;
    }
  }
}
