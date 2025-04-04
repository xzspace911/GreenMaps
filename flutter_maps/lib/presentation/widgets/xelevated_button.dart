// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class XElevatedButton extends StatelessWidget {
  XElevatedButton({
    super.key,
    required this.onPressed,
    required this.name,
    required this.color,
    required this.width,
    required this.height,
    required this.radius,
    required this.txtColor,
    required this.fontSize,
    required this.fontFamily,
  });
  Function() onPressed;
  String name;
  String fontFamily;
  Color color;
  Color txtColor;
  double width;
  double height;
  double radius;
  double fontSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius))),
      child: Text(
        name,
        style: TextStyle(
          color: txtColor,
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
