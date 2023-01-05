import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/Controler/controller.dart';
import 'package:instagram_app/Controler/oprationController.dart';
import 'package:instagram_app/Model/post_model.dart';
import 'package:instagram_app/Pages/Screen/Widget.dart/postContainer.dart';
import 'package:instagram_app/Pages/Screen/homeScreen.dart';
import 'package:instagram_app/Utils/constant.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post_Model> postList = [];
  final Operation operation = Get.put(Operation());
  Controller controller = Get.put(Controller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  getPosts() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await Utils().firebaseFirestore.collection('posts').get();

    // Get data from docs and convert map to List
    var posts = querySnapshot.docs.map((e) {
      var snap = e.data() as Map<String, dynamic>;
      return Post_Model(
          discreption: snap["discreption"],
          uid: snap[" uid"],
          userProfileUrl: snap["userProfileUrl"],
          username: snap["username"],
          postUid: snap[" postUid"],
          dateOfPost: snap["dateOfPost"],
          postPhotoUrl: snap["postPhotoUrl"],
          like: snap["like"],
          share: snap[" share"]);
    });
    for (var post in posts) {
      postList.add(post);
    }
    //now here you must get the the
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => {
                      setState(
                        () => {},
                      )
                    },
                icon: Icon(Icons.refresh))
          ],
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          title: Text(""),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
        ),
        body: ListView.builder(
          itemCount: postList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = postList[index];
            return Column(
              children: [
                PostContainer(data, context),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ));
  }
}
