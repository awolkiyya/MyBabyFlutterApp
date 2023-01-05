import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_dialog_picker/emoji_dialog_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/Controler/controller.dart';
import 'package:instagram_app/Controler/oprationController.dart';
import 'package:instagram_app/Model/user_model.dart' as model;
import 'package:instagram_app/Pages/Screen/homeScreen.dart';
import 'dart:io';

import 'package:instagram_app/Utils/constant.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  model.User? user;
  TextEditingController post = new TextEditingController();
  File? file;
  bool mouseOver = false;
  Operation operation = Get.put(Operation());
  Controller controller = Get.put(Controller());
  selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            titlePadding: EdgeInsets.symmetric(horizontal: 30),
            backgroundColor: Color.fromARGB(255, 33, 32, 32),
            children: [
              InkWell(
                onTap: () => {pickImage()},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 30,
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {pickImage()},
                      icon: Icon(Icons.image),
                    ),
                    Text("Gallary")
                  ]),
                ),
              ),
              InkWell(
                onTap: () => {pickCamera},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 30,
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {pickCamera},
                      icon: Icon(Icons.camera),
                    ),
                    Text("Camera")
                  ]),
                ),
              ),
              InkWell(
                onTap: () => {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 30,
                  child: Row(children: [
                    IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.close),
                    ),
                    Text("Close")
                  ]),
                ),
              ),
            ],
          );
        });
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => file = imageTemp);
    } on PlatformException catch (e) {
      Get.snackbar("Error", 'Failed to pick image: $e');
    }
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => file = imageTemp);
    } on PlatformException catch (e) {
      Get.snackbar("Error", 'Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  getUser() async {
    String uid = await Utils().firebaseAuth.currentUser!.uid;
    DocumentSnapshot snapshot =
        await Utils().firebaseFirestore.collection("users").doc(uid).get();
    user = model.User(
      email: (snapshot.data()! as Map<String, dynamic>)["email"],
      username: (snapshot.data()! as Map<String, dynamic>)["username"],
      profileUrl: (snapshot.data()! as Map<String, dynamic>)["profilrUrl"],
      uid: (snapshot.data()! as Map<String, dynamic>)["uid"],
    );
    print(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return file == null
        ? Center(
            child: IconButton(
              icon: Icon(
                Icons.upload,
                size: 40,
                color: Color.fromARGB(255, 142, 253, 216),
              ),
              onPressed: () => {selectImage(context)},
            ),
          )
        : Obx(
            () {
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    operation.isposting()
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              width: 30,
                              height: 5,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              // color: Colors.amberAccent,
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 142, 253, 216),
                              ),
                            ),
                          )
                        : TextButton(
                            child: Text(
                              "Post",
                              style: TextStyle(
                                color: Color.fromARGB(255, 142, 253, 216),
                              ),
                            ),
                            onPressed: () => {
                              operation.isposting.value = true,
                              operation.posting(user, post.text, file),
                              Get.snackbar(
                                  "Success", "Your Post is Successfull!"),
                              operation.isposting.value = false,
                              controller.index.value = 0,
                            },
                          )
                  ],
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => {
                      setState(
                        () => {
                          file = null,
                        },
                      )
                    },
                  ),
                  backgroundColor: Colors.black,
                  title: Text("Posting Screen"),
                ),
                body: Center(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: -10,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: FileImage(file!), fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 50,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.amber,/
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "${user?.profileUrl}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${user?.username}",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  // color: Color.fromARGB(255, 142, 253, 216),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 50,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 100,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: post,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 200,
                                  decoration: InputDecoration(
                                    hintText: "comment here",
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              EmojiButton(
                                emojiPickerView: EmojiPickerView(
                                    onEmojiSelected: (String emoji) {
                                  post.text += emoji;
                                }),
                                child: const Icon(Icons.emoji_emotions,
                                    color: Colors.amber),
                              ),
                              IconButton(
                                  onPressed: () => {pickImage()},
                                  icon: Icon(
                                    Icons.image,
                                    color: Colors.amber,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
