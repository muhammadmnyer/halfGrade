import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/presentation_layer/logic_holders/available_quizzes_cubit/available_quizzes_cubit.dart';
import 'package:half_grade/presentation_layer/widgets/loading_indicator.dart';


class AvailableQuizzesScreen extends StatefulWidget {
  final String topic;

  const AvailableQuizzesScreen({super.key, required this.topic});

  @override
  State<AvailableQuizzesScreen> createState() => _AvailableQuizzesScreenState();
}

class _AvailableQuizzesScreenState extends State<AvailableQuizzesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AvailableQuizzesCubit>(context).load(topic: widget.topic);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AvailableQuizzesCubit, AvailableQuizzesState>(
        listener: (context, state) {
          //TODO:implement error handling functionality
        },
        builder: (context, state) {
          if(state is AvailableQuizzesLoaded){
            return SafeArea(
              child: AnimatedList(
                itemBuilder: (context, index, animation) => SlideTransition(
                  position: Tween<Offset>(
                      begin: const Offset(-1, 0), end: const Offset(0, 0))
                      .animate(animation),
                  child: ListTile(
                    leading: const Icon(Icons.school),
                    title: Text(state.metadata[index]['exam_name']),
                    onTap: () =>
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          '/exam?id=${state.metadata[index]['exam_id']}',
                        ),
                  ),
                ),
                initialItemCount: state.metadata.length,
              ),
            );
          }
          return const LoadingIndicator();
        },
      ),
    );
  }
}
