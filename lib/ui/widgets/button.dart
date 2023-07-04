import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function? onTap;
  final String? label;
  final EdgeInsetsGeometry? padding;

  MyButton({
    this.onTap,
    this.label,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: 50,
        width: 200, // mareste width
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage("lib/img/loginbtn.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            label!,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}