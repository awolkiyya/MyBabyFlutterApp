import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/Controler/controller.dart';
import 'package:instagram_app/Pages/splashScreen.dart';
import 'package:get/get.dart';

void main() async {
  //  before start the code initialization of the firebase is needed
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Controller controller = Get.put(Controller());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // in flutter theme is the widget it also used to share the app colors and font style accross applicatiom
    return Obx(
      () {
        return GetMaterialApp(
          title: "instagram",
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: controller.theme.value,
          ),
          debugShowCheckedModeBanner: false,
          home: Splash(),
        );
      },
    );
  }
}
