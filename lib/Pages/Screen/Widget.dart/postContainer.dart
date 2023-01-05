import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:instagram_app/Model/post_model.dart';

Widget PostContainer(Post_Model model, context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    height: 600,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color.fromARGB(255, 7, 7, 7),
    ),
    child: Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(model.userProfileUrl!),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text(model.username!),
                // Text(
                //     "${DateTime.parse(model.dateOfPost.toDate().toString())}"),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(model.postPhotoUrl!), fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(onPressed: () => {}, icon: Icon(Icons.heart_broken)),
            IconButton(onPressed: () => {}, icon: Icon(Icons.share)),
            IconButton(onPressed: () => {}, icon: Icon(Icons.comment)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Text("${model.like!.length} likes"),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Expanded(child: Text(model.discreption!)),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Text(
                  "Post Date :${DateTime.parse(model.dateOfPost.toDate().toString())}"),
            ],
          ),
        ),
      ],
    ),
  );
}
