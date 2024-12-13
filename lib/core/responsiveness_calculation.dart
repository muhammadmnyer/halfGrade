import 'package:flutter/cupertino.dart';

double responsivenessCalculation(BuildContext context,double desiredHeight){
  final screenHeight = MediaQuery.sizeOf(context).height;
  final double finalHeight = screenHeight * desiredHeight / 800;
  return finalHeight;
}