import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:top_back/pages/widget/input_drop.dart';

class UserEditDrop extends StatelessWidget {
  UserEditDrop(
    this.current,
    this.items, {
    super.key,
    required this.onChanged,
    required this.enable,
    this.isCreate = false,
  });

  final String current;

  final bool enable;

  final Future<List<String>> Function(String, LoadProps?)? items;

  final Function(String?) onChanged;

  final bool isCreate;

  final disableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Color(0xFFE5E5E5), width: 1),
  );

  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.blue, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return InputDrop(
      current,
      items,
      enable: enable,
      onChanged: onChanged,
      defBorder: isCreate ? disableBorder : null,
      style: isCreate ? TextStyle(color: Colors.black, fontSize: 14) : null,
    );
  }
}
