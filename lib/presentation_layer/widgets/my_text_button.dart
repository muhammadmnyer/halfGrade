import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isBold;
  const MyTextButton({super.key, required this.text, required this.onPressed,this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontWeight: isBold?FontWeight.bold:null),
        ));
  }
}
