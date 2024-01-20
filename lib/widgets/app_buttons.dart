//button 4 ppl no
import 'package:flutter/material.dart';
import 'package:tourist_guide/widgets/app_text.dart';
import 'package:tourist_guide/misc/colors.dart';

class AppButtons extends StatelessWidget {
  final Color color;
  String? text;
  IconData? icon;
  final Color backgroundColor;
  double size;
  final Color borderColor;
  bool? isIcon;

  AppButtons({
    Key? key,
    this.isIcon = false,
    this.text = "hi",
    this.icon,
    required this.size,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: Center(
        child: isIcon == false
            ? AppText(
                text: text!,
                size: 18,
                color: color,
              )
            : Center(
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
      ),
    );
  }
}
