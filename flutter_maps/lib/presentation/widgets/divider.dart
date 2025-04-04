// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class XDivider extends StatelessWidget {
   XDivider({
    super.key,
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  Color color;
  double thickness;
  double indent;
  double endIndent;


  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: thickness,
      endIndent: endIndent,
      indent: indent,
    );
  }
}