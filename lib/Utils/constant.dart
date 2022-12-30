import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Utils {
  final Color dark = Colors.black;
  final Color light = Colors.white;
  final int webSize = 600;
  //  this is enable the repitation minimized
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
}
