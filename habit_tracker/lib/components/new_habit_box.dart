import 'package:flutter/material.dart';

class EnterNewHabitBox extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onSave;
  final Function()? onCancel;
  const EnterNewHabitBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "eg. code app",
          hintStyle: const TextStyle(color: Colors.white30),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: Colors.black,
          child: const Text(
            "save",
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: onCancel,
          color: Colors.black,
          child: const Text(
            "cancel",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
