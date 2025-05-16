import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_back/pages/widget/input_drop.dart';
import 'package:top_back/pages/widget/input_edit.dart';
import 'package:top_back/util/utils.dart';

class SearchEditInput extends StatelessWidget {
  SearchEditInput({
    super.key,
    this.input,
    this.formatter,
    this.validator,
    required this.maxLine,
  });

  final TextEditingController? input;

  final List<TextInputFormatter>? formatter;

  final String? Function(String?)? validator;

  final int maxLine;

  SearchEditInput.title(this.input)
      : formatter = [LengthLimitingTextInputFormatter(30)],
        validator = Utils.onValidatorEmpty,
        maxLine = 1;

  SearchEditInput.sort(this.input)
      : formatter = [FilteringTextInputFormatter.digitsOnly],
        validator = Utils.onValidatorEmpty,
        maxLine = 1;

  SearchEditInput.inter(this.input)
      : formatter = null,
        validator = Utils.onValidatorEmpty,
        maxLine = 3;

  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Color(0xFFE5E5E5), width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return InputEdit(
      input,
      true,
      formatter: formatter,
      validator: validator,
      maxLine: maxLine,
      defBorder: enableBorder,
      maxWidth: 300,
    );
  }
}

class SearchEditDrop extends StatelessWidget {
  SearchEditDrop(
    this.current,
    this.items, {
    super.key,
    required this.onChanged,
    required this.enable,
    this.validator,
  });

  final String current;

  final bool enable;

  final Future<List<String>> Function(String, LoadProps?)? items;

  final Function(String?) onChanged;

  final String? Function(String?)? validator;

  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Color(0xFFE5E5E5), width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return InputDrop(
      current,
      items,
      validator: validator,
      defBorder: enableBorder,
      showSearch: true,
      maxWidth: 300,
      onChanged: onChanged,
      hint: "输入查找已有话题",
    );
  }
}
