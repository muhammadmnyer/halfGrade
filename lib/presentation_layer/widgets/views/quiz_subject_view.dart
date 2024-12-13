import 'package:flutter/material.dart';

class QuizSubjectView extends StatelessWidget {

  final String imageLink;
  final String subjectName;
  final void Function() onTap;

  const QuizSubjectView({
        super.key,
        required this.imageLink,
        required this.subjectName,
        required this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,

        onTap: onTap,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.topRight,
          children: [
            Image.network(
              height: double.infinity,
              width: double.infinity,
              imageLink,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subjectName,
                style: const TextStyle(
                    backgroundColor: Colors.black,
                    color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
