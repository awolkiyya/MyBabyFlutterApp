import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/Controler/controller.dart';
import "package:get/get.dart";
import 'package:instagram_app/Utils/pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Controller controller =
      Get.put(Controller()); // this is called dependancy injection in getx
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          body: pages[controller.index.value],
          bottomNavigationBar: FlashyTabBar(
            selectedIndex: controller.index.value,
            backgroundColor: Color.fromARGB(255, 1, 1, 1),
            showElevation: true,
            onItemSelected: (value) => {
              controller.index.value = value,
            },
            items: [
              FlashyTabBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: controller.index.value == 0
                          ? Colors.white
                          : Color.fromARGB(255, 108, 106, 106)),
                ),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                title: Text('Search',
                    style: TextStyle(
                        color: controller.index.value == 1
                            ? Colors.white
                            : Color.fromARGB(255, 108, 106, 106))),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.add_circle,
                  size: 30,
                ),
                title: Text('Upload',
                    style: TextStyle(
                        color: controller.index.value == 2
                            ? Colors.white
                            : Color.fromARGB(255, 108, 106, 106))),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.heart_broken,
                  size: 30,
                ),
                title: Text('Likes',
                    style: TextStyle(
                        color: controller.index.value == 3
                            ? Colors.white
                            : Color.fromARGB(255, 108, 106, 106))),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.person,
                ),
                title: Text('Profile',
                    style: TextStyle(
                        color: controller.index.value == 4
                            ? Colors.white
                            : Color.fromARGB(255, 108, 106, 106))),
              ),
            ],
          ),
        );
      },
    );
  }
}
