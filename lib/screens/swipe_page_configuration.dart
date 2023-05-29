import 'package:bordeaux/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SwipeToNavigate extends StatefulWidget {
  final Function? onSwipeLeft;
  final Function? onSwipeRight;

  const SwipeToNavigate({Key? key, this.onSwipeLeft, this.onSwipeRight}) : super(key: key);

  @override
  State<SwipeToNavigate> createState() => _SwipeToNavigateState();
}

class _SwipeToNavigateState extends State<SwipeToNavigate> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          if (widget.onSwipeLeft != null) {
            widget.onSwipeLeft!();
          } else {
            Get.back();
          }
        } else if (details.primaryVelocity! > 0) {
          if (widget.onSwipeRight != null) {
            widget.onSwipeRight!();
          } else {
            Get.to(() => ProfileScreen());
          }
        }
      },
    );
  }
}