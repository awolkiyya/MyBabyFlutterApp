import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/Controler/controller.dart';
import 'package:instagram_app/Pages/Screen/profileEditingScreen.dart';
import 'dart:io';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  File? imageFile = File.fromUri(Uri(
      path:
          "https://i.pinimg.com/474x/a3/a5/66/a3a56629b3e2ee5a103db24657d00ac9.jpg"));
  String _selectedGender = 'male';
  //  now make the controller for the inputfields
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirm = new TextEditingController();
  TextEditingController username = new TextEditingController();
  Controller controller =
      Get.put(Controller()); // this is called dependancy injection in getx
  bool _isdropup = true;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => imageFile = imageTemp);
    } on PlatformException catch (e) {
      Get.snackbar("Error", 'Failed to pick image: $e');
    }
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => imageFile = imageTemp);
    } on PlatformException catch (e) {
      Get.snackbar("Error", 'Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.only(top: 30),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://thumbs.dreamstime.com/b/new-life-concept-seedling-growing-sprout-tree-new-life-concept-seedling-growing-sprout-tree-business-development-99382656.jpg"),
                          fit: BoxFit.cover),
                      color: Color.fromARGB(255, 142, 253, 216),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 4.5,
                left: MediaQuery.of(context).size.height / 8.2,
                child: Container(
                  // color: Colors.amber,
                  width: 200,
                  height: 180,
                  // color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        radius: 50,
                        child: InkWell(
                          onTap: () => {
                            Get.to(ProfileEditScreen(imageUrl: imageFile),
                                transition: Transition.downToUp),
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(imageFile!),
                              ),
                            ),
                          ),
                        ), //Text
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Positioned(
                            top: 55,
                            left: 60,
                            child: IconButton(
                              icon: Icon(
                                Icons.image,
                                color: Color.fromARGB(255, 142, 253, 216),
                                size: 30,
                              ),
                              onPressed: () {
                                pickImage();
                              },
                            ),
                          ),
                          Positioned(
                            top: 55,
                            left: 60,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Color.fromARGB(255, 142, 253, 216),
                                size: 30,
                              ),
                              onPressed: () {
                                pickCamera();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              controller.isDropUp()
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Positioned(
                        top: 400,
                        child: Container(
                          padding: EdgeInsets.only(top: 50),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Color.fromARGB(255, 0, 0, 0),
                          child: Center(
                            child: ListView(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: username,
                                        decoration: InputDecoration(
                                          labelText: "username",
                                          icon: Icon(
                                              Icons.supervised_user_circle),
                                        ),
                                      ),
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
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: Color.fromARGB(
                                              255, 142, 253, 216),
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 40,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 142, 253, 216),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          onTap: () async => {
                                            controller.issearchprogress.value =
                                                true,
                                            await controller.register(
                                                username.text,
                                                email.text,
                                                password.text,
                                                imageFile!),
                                            controller.issearchprogress.value =
                                                false,
                                          },
                                          child: Center(
                                            child: Text(
                                              "Register",
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
                                    Text(" I Have Account  "),
                                    InkWell(
                                      child: Text(
                                        "Login Here !",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 142, 253, 216),
                                            fontWeight: FontWeight.w900),
                                      ),
                                      onTap: () => {
                                        Get.back(),
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                IconButton(
                                    onPressed: () => {
                                          controller.isdropup.value = false,
                                        },
                                    icon: Icon(Icons.arrow_downward))
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Positioned(
                      top: 350,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 800,
                        color: Color.fromARGB(255, 4, 4, 4),
                        child: Center(
                          child: ListView(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () => {
                                            controller.isdropup.value = true,
                                          },
                                          icon: Icon(Icons.arrow_upward),
                                        ),
                                        Text("DropUp The Form To FullScreen"),
                                      ],
                                    ),
                                    TextField(
                                      controller: username,
                                      decoration: InputDecoration(
                                        labelText: "username",
                                        icon:
                                            Icon(Icons.supervised_user_circle),
                                      ),
                                    ),
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
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color:
                                            Color.fromARGB(255, 142, 253, 216),
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 142, 253, 216),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
                                        onTap: () async => {
                                          controller.issearchprogress.value =
                                              true,
                                          await controller.register(
                                              username.text,
                                              email.text,
                                              password.text,
                                              imageFile!),
                                          controller.issearchprogress.value =
                                              false,
                                        },
                                        child: Center(
                                          child: Text(
                                            "Register",
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
                                  Text(" I Have Account  "),
                                  InkWell(
                                    child: Text(
                                      "Login Here !",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 142, 253, 216),
                                          fontWeight: FontWeight.w900),
                                    ),
                                    onTap: () => {
                                      Get.back(),
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
                    )
            ],
          ),
        );
      },
    );
  }
}
