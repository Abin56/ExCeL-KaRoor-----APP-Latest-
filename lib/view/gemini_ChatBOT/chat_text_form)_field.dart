import 'package:flutter/material.dart';

class ChatTextFormFiled extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? textController;
  final bool isReadyOnly;
  final void Function(String)? onFieldSubmitted;

  const ChatTextFormFiled(
      {super.key,
      this.focusNode,
      this.textController,
      this.isReadyOnly = false,
      required this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      autocorrect: false,
      controller: textController,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: isReadyOnly,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: 'Enter your prompt...',
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(32)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(32)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some prompt';
        }
        return null;
      },
    );
  }
}
