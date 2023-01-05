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
    return Obx(
      () {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(backgroundColor: Colors.black, actions: [
            IconButton(
                onPressed: () => {
                      Get.defaultDialog(
                        contentPadding: EdgeInsets.all(20),
                        title: "Welcome to My Baby Apps",
                        middleText:
                            "This App Help You To Get Your Every Days Changes Of Your Child And You Can Get Diffrent Information and Advices  Of Your Child From Every User Of This App Around The Worlds!!",
                        backgroundColor: Color.fromARGB(255, 142, 253, 216),
                        titleStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        middleTextStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    },
                icon: Icon(Icons.info_outline))
          ]),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/black1.gif",
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome To My Baby App",
                    style: TextStyle(
                        color: Color.fromARGB(255, 142, 253, 216),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
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
                    height: 30,
                  ),
                  controller.setting()
                      ? CircularProgressIndicator(
                          color: Color.fromARGB(255, 142, 253, 216),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 142, 253, 216),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () async => {
                              controller.issearchprogress.value = true,
                              await controller.login(email.text, password.text),
                              controller.issearchprogress.value = false,
                            },
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Don't Have Account Yet  "),
                      InkWell(
                        child: Text(
                          "Register Here !",
                          style: TextStyle(
                              color: Color.fromARGB(255, 142, 253, 216),
                              fontWeight: FontWeight.w900),
                        ),
                        onTap: () => {
                          Get.to(() => RegistrationScreen(),
                              transition: Transition.leftToRightWithFade)
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
