import 'package:flutter/material.dart';

class DialogBase extends StatelessWidget {
  final Widget child;
  const DialogBase({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }
}

