
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'chiled_color_book/view/Home_Screen.dart';
void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,

        routes: {
          '/':(context) => Drawingscreen(),
        },
      ),
    ),
  );
}