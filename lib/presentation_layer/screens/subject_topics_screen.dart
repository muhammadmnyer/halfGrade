import 'package:flutter/material.dart';

class SubjectTopicsScreen extends StatefulWidget {
  final List<String> topics;

  const SubjectTopicsScreen({super.key, required this.topics});

  @override
  State<SubjectTopicsScreen> createState() => _SubjectTopicsScreenState();
}

class _SubjectTopicsScreenState extends State<SubjectTopicsScreen> {
  late final GlobalKey<AnimatedListState> key = GlobalKey();
  final List<String> _topics = [];
  @override
  void initState() {
    super.initState();

    Future.forEach(
        widget.topics,
        (element) async=> await Future.delayed(const Duration(milliseconds: 250,),(){
          key.currentState!.insertItem(_topics.length,duration: const Duration(milliseconds: 300));
          _topics.add(element);
        }),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedList(
          key: key,
          itemBuilder: (context, index, animation) => SlideTransition(
            position:
              Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
                  .animate(animation),
          child: ListTile(
                onTap: () {
                  Navigator.of(context, rootNavigator: false)
                      .pushNamed('available_quizzes',arguments: _topics[index]);
                },
                title: Text(_topics[index]),
                leading: const Icon(Icons.school),
              ),
          ),
        initialItemCount: _topics.length,
      ),
    );
  }
}
