import 'package:flutter/material.dart';

class InputBasic extends StatelessWidget {
  const InputBasic(
      {super.key, required this.editingController, required this.hint});
  final TextEditingController editingController;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: editingController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          isDense: true,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Color(0xffA6A6A6),
          ),
        ),
      ),
    );
  }
}
