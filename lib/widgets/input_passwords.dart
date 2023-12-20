import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  const InputPassword(
      {super.key, required this.editingController, required this.hint});
  final TextEditingController editingController;
  final String hint;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool isHide = true;
  setHide() {
    isHide = !isHide;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(left: 16, right: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.editingController,
              obscureText: isHide,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                isDense: true,
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color(0xffA6A6A6),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: setHide,
            icon: Icon(
              isHide
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
        ],
      ),
    );
  }
}