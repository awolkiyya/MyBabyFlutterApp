import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Controler/controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Controller controller =
      Get.put(Controller()); // this is called dependancy injection in getx
  @override
  void initState() {
    print(controller.theme.value);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text("Registration Screen"),
            actions: [
              controller.isDark()
                  ? IconButton(
                      icon: Icon(Icons.dark_mode),
                      onPressed: () => {
                        controller.isdarkmode.value = false,
                        controller.theme.value = Colors.white,
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.light_mode),
                      onPressed: () => {
                        controller.isdarkmode.value = true,
                        controller.theme.value = Colors.black,
                      },
                    )
            ],
          ),
          body: Center(
              child: Text("Registration Screen${controller.theme.value}")),
        );
      },
    );
  }
}
