import 'package:flutter/material.dart';

class MyMainButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final Color backgroundColor;
  const MyMainButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.black
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const  EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: backgroundColor,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 20,color: Colors.white),
        ),
      ),
    );
  }
}
