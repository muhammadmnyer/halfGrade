import 'package:flutter/material.dart';
import 'package:half_grade/presentation_layer/widgets/dialogs/dialog_base.dart';

class QuizSolvedQuestionView extends StatelessWidget {
  final String question;
  final String a,b,c,d;
  final String correctAnswer;
  final String? explanation;
  final String? selectedAnswer;

  const QuizSolvedQuestionView({
    super.key,
    required this.question,
    required this.correctAnswer,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.explanation,
    required this.selectedAnswer
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              Text(question),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                title: Text(a),
                leading: Radio(
                  activeColor: Colors.green,
                  value: "a",
                  groupValue: correctAnswer,
                  onChanged: (value) {},
                ),
              ),
              ListTile(
                title: Text(b),
                leading: Radio(
                  activeColor: Colors.green,
                  value: "b",
                  groupValue: correctAnswer,
                  onChanged: (value) {},
                ),
              ),
              ListTile(
                title: Text(c),
                leading: Radio(
                  activeColor: Colors.green,
                  value: "c",
                  groupValue: correctAnswer,
                  onChanged: (value) {},
                ),
              ),
              ListTile(
                title: Text(d),
                leading: Radio(
                  activeColor: Colors.green,
                  value: "d",
                  groupValue: correctAnswer,
                  onChanged: (value) {},
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                    'selected answer is ${selectedAnswer ?? 'none'}'),
              ),
            ],
          ),
          explanation != null
              ? InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogBase(
                          child: Center(
                            child: Text(explanation!),
                      ));
                      },
                    );
                  },
                  child: const Icon(
                    Icons.info,
                    color: Colors.grey,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
