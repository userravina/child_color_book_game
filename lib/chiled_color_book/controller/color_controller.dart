import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/draw_model.dart';
import '../view/Home_Screen.dart';

class Drawingcontroller extends GetxController {
  // var pickcolor = Color(0xff000000).obs;
  RxDouble slider=0.0.obs;
  var currentcolor = Color(0xff000000).obs;
  RxList<Drawingmodal> points = <Drawingmodal>[].obs;
  List<Color> colorlist = [
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.grey,
    Colors.amber,
    Colors.teal,
    Colors.indigo,
    Colors.blue,
    Colors.lime,
    Colors.white,
    Colors.black,
    Colors.green,
    Colors.tealAccent,
    Colors.pink,

  ];
}