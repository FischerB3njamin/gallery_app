import 'package:flutter/material.dart';

class NewItemTextField extends StatelessWidget {
  const NewItemTextField(
      {super.key, required this.textController, required this.label});

  final TextEditingController textController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: null,
        minLines: 1,
        controller: textController,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
