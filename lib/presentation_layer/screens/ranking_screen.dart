import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/core/responsiveness_calculation.dart';
import 'package:half_grade/presentation_layer/logic_holders/ranking_screen_cubit/ranking_screen_cubit.dart';
import 'package:half_grade/presentation_layer/widgets/dialogs/retry_dialog.dart';
import 'package:half_grade/presentation_layer/widgets/loading_indicator.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RankingScreenCubit,RankingScreenState>(
          listener: (context, state) {
            if(state is RankingScreenFailure){
              retryDialog(
                context,
                errorMessage: state.error,
                retry: () => BlocProvider.of<RankingScreenCubit>(context).load(),
              );
            }
          },
          builder: (context, state) {

            if(state is RankingScreenLoaded){
              return RefreshIndicator(
                onRefresh: () async=> BlocProvider.of<RankingScreenCubit>(context).load(),
                child: Column(
                  children: [
                    SizedBox(height: responsivenessCalculation(context, 80),),
                    const Text(
                        "All-Time Legends",
                      style: TextStyle(
                        fontSize: 24,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20,right: 20,bottom: 100),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)
                        ),
                        child: ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 8,),
                            itemBuilder: (context, index) => ListTile(
                              leading: Text(
                                  "#${index + 1}",
                                style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                              ),
                              title: Text(
                                  state.topUsers[index].username,
                                style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(state.topUsers[index].schoolName),
                              trailing: Text(
                                state.topUsers[index].points.toString(),
                                style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                              ),
                            ),
                            separatorBuilder: (context, index) => const SizedBox(height: 8,),
                            itemCount: state.topUsers.length
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const LoadingIndicator();
          },
      ),
    );
  }
}
