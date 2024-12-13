import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xffeed9c4),
            const Color(0xffFAF9F6).withOpacity(0.9)
          ], begin: Alignment.topLeft, end: Alignment.bottomCenter)),
      height: double.infinity,
      width: double.infinity,
      child: child,
    );
  }
}
