import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownBtn extends StatefulWidget {
  const DropdownBtn({
    super.key,
    required this.menuList,
    this.init,
    this.hint,
    this.height,
    this.width,
    this.selectedItemBuilder,
    this.onChanged,
  });

  final String? hint;

  final double? width;

  final double? height;

  /// 按对应选项的下标 -1为重置
  final int? init;

  final DropdownButtonBuilder? selectedItemBuilder;

  final Function(int)? onChanged;

  final List<String> menuList;

  @override
  State<DropdownBtn> createState() => _DropdownBtnState();
}

class _DropdownBtnState extends State<DropdownBtn> {
  String? indexValue;

  @override
  void initState() {
    super.initState();
    if (widget.init != null) {
      indexValue = widget.init == -1 ? null : "${widget.init}";
    }
  }

  @override
  void didUpdateWidget(covariant DropdownBtn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.init != null) {
      indexValue = widget.init == -1 ? null : "${widget.init}";
    }
  }

  void onStatusChanged(String? value) {
    indexValue = value;
    if (mounted) setState(() {});
    if (indexValue != null && widget.onChanged != null) {
      widget.onChanged!(int.parse(indexValue!));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget hint = Center(
      child: Text(
        widget.hint ?? "",
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: widget.hint == null ? null : hint,
        items: List.generate(
          widget.menuList.length,
          (i) => DropdownMenuItem(value: "$i", child: Text(widget.menuList[i])),
        ),
        selectedItemBuilder: widget.selectedItemBuilder,
        value: indexValue,
        onChanged: onStatusChanged,
        buttonStyleData: ButtonStyleData(
          padding: EdgeInsets.zero,
          height: widget.height ?? 36,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFFEBEBEB), width: 1),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.black12),
          openMenuIcon: Icon(Icons.keyboard_arrow_up, color: Colors.black12),
        ),
      ),
    );
  }
}
