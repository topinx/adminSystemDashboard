import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AccountInfoText extends StatelessWidget {
  const AccountInfoText(this.text1, this.ctr, {super.key, this.enable});

  final String text1;

  final TextEditingController ctr;

  final bool? enable;

  Widget buildTextField(BuildContext context) {
    return TextField(
      enabled: enable ?? false,
      controller: ctr,
      style: const TextStyle(color: Colors.black, fontSize: 14),
      decoration: const InputDecoration(
        constraints: BoxConstraints(maxHeight: 25, maxWidth: 240),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 60, child: Text(text1)),
        const Text(":"),
        buildTextField(context),
      ]),
    );
  }
}

class AccountInfoDrop extends StatefulWidget {
  const AccountInfoDrop(this.text1, this.status, this.menuList,
      {super.key, this.enable, required this.onChange});

  final String text1;

  final int status;

  final List<String> menuList;

  final bool? enable;

  final Function(int) onChange;

  @override
  State<AccountInfoDrop> createState() => _AccountInfoDropState();
}

class _AccountInfoDropState extends State<AccountInfoDrop> {
  String? indexValue;

  @override
  void initState() {
    super.initState();
    indexValue = "${widget.status}";
  }

  @override
  void didUpdateWidget(covariant AccountInfoDrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    indexValue = "${widget.status}";
  }

  void onStatusChanged(String? value) {
    indexValue = value;
    if (mounted) setState(() {});
    widget.onChange(int.tryParse(indexValue ?? "") ?? widget.status);
  }

  Widget buildDropButton() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: false,
        items: List.generate(
          widget.menuList.length,
          (i) => DropdownMenuItem(value: "$i", child: Text(widget.menuList[i])),
        ),
        value: indexValue,
        onChanged: widget.enable == true ? onStatusChanged : null,
        selectedItemBuilder: (_) => List.generate(
          widget.menuList.length,
          (i) => Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(widget.menuList[i],
                style: const TextStyle(color: Colors.black, fontSize: 14)),
          ),
        ),
        buttonStyleData: ButtonStyleData(
          padding: EdgeInsets.zero,
          height: 25,
          width: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: widget.enable == true
                    ? const Color(0xFFEBEBEB)
                    : Colors.transparent,
                width: 1),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        iconStyleData:
            const IconStyleData(icon: SizedBox(), openMenuIcon: SizedBox()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 60, child: Text(widget.text1)),
        const Text(":"),
        buildDropButton(),
      ]),
    );
  }
}
