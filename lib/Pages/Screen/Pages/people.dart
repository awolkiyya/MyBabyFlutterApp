import 'package:flutter/material.dart';
import 'package:instagram_app/Controler/controller.dart';
import "package:get/get.dart";

class People extends StatefulWidget {
  const People({super.key});
  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: Text("Logout"),
        onPressed: () => {controller.logout()},
      )),
    );
  }
}
