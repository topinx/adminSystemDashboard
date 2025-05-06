import 'package:flutter/material.dart';

class InputSearch extends StatelessWidget {
  InputSearch(this.input, this.onTap, {super.key});

  final TextEditingController input;

  final Function() onTap;

  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Color(0xFFCECECE), width: 1),
  );

  final focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.blue, width: 1),
  );

  Widget buildSearchButton() {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(100, 38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        backgroundColor: Colors.blue,
      ),
      child: Text("搜索", style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Spacer(),
      Expanded(
        flex: 2,
        child: TextField(
          controller: input,
          decoration: InputDecoration(
            constraints: const BoxConstraints(minHeight: 25),
            isDense: true,
            enabledBorder: enableBorder,
            focusedBorder: focusBorder,
          ),
        ),
      ),
      const SizedBox(width: 10),
      buildSearchButton(),
      Spacer(),
    ]);
  }
}
