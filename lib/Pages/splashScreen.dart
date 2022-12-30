import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:instagram_app/Pages/Screen/mobileScreen.dart';
import 'package:instagram_app/Pages/Screen/webScreen.dart';
import 'package:instagram_app/Utils/responsive_layout.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 1000,
      centered: true,
      duration: 80000,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      splash: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/white.gif",
              width: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Baby App 2023",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      nextScreen:
          ResponseLayout(mobileScreen: MobileScreen(), webScreen: WebScreen()),
    );
  }
}
