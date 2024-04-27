import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final Color? color;
  final String? text;
  final double? height;
  final double? width;
  final void Function()? onTap;
  const MyCustomButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.text,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
