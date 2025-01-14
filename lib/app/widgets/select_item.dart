import 'package:flutter/material.dart';

class SelectItem extends StatelessWidget {
  const SelectItem(this.text, this.active, {super.key, this.onTap});

  final String text;

  final bool active;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      child: Row(children: [
        Icon(active ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            size: 14, color: active ? const Color(0xFF3871BB) : Colors.black),
        const SizedBox(width: 5),
        Text(
          text,
          style:
              TextStyle(color: active ? const Color(0xFF3871BB) : Colors.black),
        ),
      ]),
    );
  }
}
