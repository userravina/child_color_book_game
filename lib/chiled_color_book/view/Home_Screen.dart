import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../controller/color_controller.dart';

class Drawingscreen extends StatefulWidget {
  const Drawingscreen({super.key});

  @override
  State<Drawingscreen> createState() => _DrawingscreenState();
}

class _DrawingscreenState extends State<Drawingscreen> {
  Drawingcontroller controller = Get.put(Drawingcontroller());
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            setState(() {
              controller.points.clear();
              Customdrawing draw=Customdrawing(controller.points);
              draw.clear();
            });
          },
          child: Icon(Icons.close, color: Colors.white),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Stack(
            children: [
              GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    RenderBox? renderBox =
                    context.findRenderObject() as RenderBox?;
                    controller.points.add(Drawingmodal(
                        Paint()
                          ..color = controller.currentcolor.value
                          ..strokeCap = StrokeCap.round
                          ..strokeWidth = controller.slider.value
                          ..isAntiAlias = true,
                        renderBox!.globalToLocal(details.globalPosition)));
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    controller.points.add(Drawingmodal(Paint(), Offset.zero));
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    RenderBox? renderBox =
                    context.findRenderObject() as RenderBox?;
                    controller.points.add(Drawingmodal(
                        Paint()
                          ..color = controller.currentcolor.value
                          ..strokeCap = StrokeCap.round
                          ..strokeWidth = controller.slider.value
                          ..isAntiAlias = true,
                        renderBox!.globalToLocal(details.globalPosition)));
                  });
                },
                child: Container(
                  width: 100.w,
                  height: 90.h,
                  child: CustomPaint(
                    painter: Customdrawing(controller.points),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10,right: 15),
                    height: 50.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          children: controller.colorlist
                              .map((e) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                                onTap: () {
                                  controller.currentcolor.value = e;
                                },
                                child: CircleAvatar(
                                  backgroundColor: e,
                                  radius: 10.sp,
                                )),
                          ))
                              .toList()),
                    ),
                  ),
                  SizedBox(height: 100),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 200,right: 50),
                        child: Obx(
                              () => SfSlider(
                            min: 0,
                            activeColor: Colors.black,
                            inactiveColor: Colors.indigo.shade100,
                            max: 20,
                            value: controller.slider.value,
                            onChanged: (value) {
                              controller.slider.value = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Drawingmodal {
  Paint paint;
  Offset offset;

  Drawingmodal(this.paint, this.offset);
}

class Customdrawing extends CustomPainter {
  List<Drawingmodal> pointsList;

  Customdrawing(this.pointsList);

  List<Offset> offlist = [];

  void clear()
  {
    pointsList.clear();
    offlist.clear();
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < (pointsList.length - 1); i++) {
      if (pointsList[i] != null && pointsList[i + 1] == null) {
        canvas.drawLine(pointsList[i].offset, pointsList[i + 1].offset,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] != null) {
        offlist.clear();
        offlist.add(pointsList[i].offset);
        offlist.add(Offset(
            pointsList[i].offset.dx + 0.1, pointsList[i].offset.dy + 0.1));
        canvas.drawPoints(PointMode.points, offlist, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

