// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
class ProgressButtonWidget extends StatelessWidget {
  final ButtonState buttonstate;
  final String text;
  final Function function;

  const ProgressButtonWidget({
    super.key,
    required this.buttonstate,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ProgressButton.icon(
      // radius: 12,
      iconedButtons: {
        ButtonState.idle: IconedButton(
          text: text,
          icon: const Icon(Icons.send, color: Colors.white),
          color: adminePrimayColor,
        ),
        ButtonState.loading:
            IconedButton(text: 'Loading', color: Colors.deepPurple.shade700),
        ButtonState.fail: IconedButton(
          text: 'Failed',
          icon: const Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300,
        ),
        ButtonState.success: IconedButton(
          text: 'Success',
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400,
        )
      },
      onPressed: function,
      state: buttonstate,
    );
  }
}
