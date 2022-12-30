import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Controler/controller.dart';
import 'package:instagram_app/Pages/Screen/registrationScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // now here make dependency injection  using getx
  Controller controller = Get.put(Controller());
  //  now make the controller for the inputfields
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              "assets/black1.gif",
              width: 150,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Welcome To Baby App",
            style: TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "email",
                    icon: Icon(Icons.email),
                  ),
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: "password",
                    icon: Icon(Icons.password),
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () => {controller.login(email.text, password.text)},
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Don't Have Account Yet  "),
              InkWell(
                child: Text(
                  "Register Here !",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
                ),
                onTap: () => {Get.to(RegistrationScreen())},
              )
            ],
          )
        ],
      ),
    );
  }
}
