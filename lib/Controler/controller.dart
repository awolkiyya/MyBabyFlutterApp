import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Model/user_model.dart' as model;
import 'package:instagram_app/Pages/Screen/homeScreen.dart';
import 'package:instagram_app/Pages/splashScreen.dart';
import 'package:instagram_app/Utils/constant.dart';
import 'dart:io';

class Controller extends GetxController {
  late Rx<User?> user;
  RxInt index = 0.obs;
  // Rx<User?> getUser() => user;
  Rx<Color> theme = Colors.black.obs;
  final RxBool isdarkmode = true.obs;
  final RxBool issearchprogress = false.obs;
  final RxBool isdropup = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("every time the contoller called");
  }

  @override
  void onReady() {
    super.onReady();
    print("every time the render the widget");
    user = Rx<User?>(Utils().firebaseAuth.currentUser);
    print("the full user information${user}");
    user.bindStream(Utils().firebaseAuth.authStateChanges());
    ever(user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => Splash());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = Utils()
        .firebaseStorage
        .ref()
        .child('profilePics')
        .child(Utils().firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user
  Future<void> register(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // save out user to our ath and firebase firestore
        UserCredential cred =
            await Utils().firebaseAuth.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
        print(
            "this is the fullinformation of registered information the firebaseAuth return \n${cred}");
        String downloadUrl = await _uploadToStorage(image);
        print(downloadUrl);
        model.User user = model.User(
          username: username,
          email: email,
          profileUrl: downloadUrl,
          uid: cred.user!.uid,
        );
        await Utils()
            .firebaseFirestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.tojson());
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }

  // there is the function that performe login operation
  Future<void> login(String email, String password) async {
    print("the data is passed is=${email} and ${password}");
    //now here used the firebaseauth to authenticate user using email and password
    try {
      if (email != "" && password != "") {
        UserCredential credential = await Utils()
            .firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
        print(
            "the current user information return from the firebaseAuth\n${credential}");
      } else {
        Get.snackbar(
            "Client Side Error", "your email or password field must be fill");
      }
    } catch (e) {
      Get.snackbar("Server Side Error", "${e}");
    }
  }

  Future<void> logout() async {
    print("before logout${Utils().firebaseAuth.currentUser}");
    await Utils().firebaseAuth.signOut();
    print("after logout${Utils().firebaseAuth.currentUser}");
  }

  bool setting() {
    if (issearchprogress.value) {
      return true;
    } else {
      return false;
    }
  }

  bool isDropUp() {
    if (isdropup.value) {
      return true;
    } else {
      return false;
    }
  }

  bool isDark() {
    if (isdarkmode.value) {
      return true;
    } else {
      return false;
    }
  }
}
