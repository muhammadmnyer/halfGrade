import 'package:flutter/material.dart';

class QuizQuestionView extends StatefulWidget {

  final String question;
  final String a, b, c, d;
  final Map<int,String> answersRef;
  final int indexKey;


  const QuizQuestionView({
      super.key,
      required this.question,
      required this.a,
      required this.b,
      required this.c,
      required this.d,
      required this.answersRef,
      required this.indexKey
  });

  @override
  State<QuizQuestionView> createState() => _QuizQuestionViewState();
}

class _QuizQuestionViewState extends State<QuizQuestionView> {

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
      child: Column(
        children: [
          Text(widget.question),
          const SizedBox(height: 8,),
          ListTile(
            title: Text(widget.a),
            leading: Radio(
              value: "a",
              groupValue: widget.answersRef[widget.indexKey],
              onChanged: (value) {
                setState(() {
                  widget.answersRef[widget.indexKey] = value!;
                });
              },
            ),
          ),
          ListTile(
            title: Text(widget.b),
            leading: Radio(
              value: "b",
              groupValue: widget.answersRef[widget.indexKey],
              onChanged: (value) {
                widget.answersRef[widget.indexKey] = value!;
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(widget.c),
            leading: Radio(
              value: "c",
              groupValue: widget.answersRef[widget.indexKey],
              onChanged: (value) {
                widget.answersRef[widget.indexKey] = value!;
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(widget.d),
            leading: Radio(
              value: "d",
              groupValue: widget.answersRef[widget.indexKey],
              onChanged: (value) {
                widget.answersRef[widget.indexKey] = value!;
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}
