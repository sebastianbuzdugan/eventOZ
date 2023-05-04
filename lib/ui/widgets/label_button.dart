import 'package:flutter/material.dart';
import 'package:loginv1/constants/theme.dart';
/*
LabelButton(
                labelText: 'Some Text',
                onPressed: () => print('implement me'),
              ),
*/

class LabelButton extends StatelessWidget {
  LabelButton({required this.labelText, required this.onPressed});
  final String labelText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      
      child: Text(
        labelText,
        style: TextStyle(
          foreground: Paint()..shader = linearGradient,
          
        ),
      ),
      onPressed: onPressed,
    );
  }
}
