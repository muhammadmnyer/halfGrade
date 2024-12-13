import 'package:flutter/material.dart';
import 'package:half_grade/presentation_layer/widgets/dialogs/dialog_base.dart';
import 'package:half_grade/presentation_layer/widgets/my_main_button.dart';

void retryDialog(BuildContext context,
    {
      required final String errorMessage,
      required final void Function() retry
}){
  showDialog(
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: DialogBase(
            child: Column(
              children: [
                Flexible(
                    child: SingleChildScrollView(child: Text(errorMessage))),
                const SizedBox(height: 4,),
                MyMainButton(
                    label: 'retry',
                    onPressed: () {
                      Navigator.of(context,rootNavigator: true).pop();
                      retry();
                    },
                )
              ],
            )
        ),
      )
  );
}