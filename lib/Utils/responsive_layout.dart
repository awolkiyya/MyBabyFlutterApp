import 'package:flutter/material.dart';
import 'package:instagram_app/Utils/constant.dart';

class ResponseLayout extends StatelessWidget {
  Widget mobileScreen;
  Widget webScreen;
  ResponseLayout(
      {super.key, required this.mobileScreen, required this.webScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth > Utils().webSize) {
          return webScreen;
        } else {
          return mobileScreen;
        }
      },
    );
  }
}
