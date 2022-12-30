import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Utils/constant.dart';
import 'dart:io';

class Controller extends GetxController {
  Rx<Color> theme = Colors.black.obs;
  final RxBool isdarkmode = true.obs;
  // there is the function that performe login operation
  Future<void> login(String email, String password) async {
    print("the data is passed is=${email} and ${password}");
    //now here used the firebaseauth to authenticate user using email and password
    try {
      if (email != "" && password != "") {
        UserCredential credential = await Utils()
            .firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar(
            "Client Side Error", "your email or password field must be fill");
      }
    } catch (e) {
      Get.snackbar("Server Side Error", "${e}");
    }
  }

  Future<void> register(String email, String password, File filename) async {
    // this function can be used to register new user of instagram
    UserCredential userCredential = await Utils()
        .firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await Utils().firebaseAuth.signOut();
  }

  bool isDark() {
    if (isdarkmode.value) {
      return true;
    } else {
      return false;
    }
  }
}
