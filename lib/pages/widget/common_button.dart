import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  const BorderButton(this.text, {super.key, this.onTap});

  final Function()? onTap;

  final String text;

  void onTapButton() {
    if (onTap != null) onTap!();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTapButton,
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(120, 25),
        side: BorderSide(color: Colors.black, width: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(text, style: TextStyle(color: Colors.black)),
    );
  }
}

class DropButton extends StatelessWidget {
  const DropButton(this.text, this.items, {super.key});

  final String text;

  final Future<List<String>> Function(String, LoadProps?)? items;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      clickProps: ClickProps(borderRadius: BorderRadius.circular(20)),
      mode: Mode.custom,
      items: items,
      popupProps: PopupProps.menu(
        menuProps: MenuProps(margin: EdgeInsets.only(top: 12)),
        fit: FlexFit.loose,
        itemBuilder: (context, item, isDisabled, isSelected) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(item, textAlign: TextAlign.center),
        ),
      ),
      dropdownBuilder: (_, string) => OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          fixedSize: const Size(120, 25),
          side: BorderSide(color: Colors.black, width: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(text, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class TxtButton extends StatelessWidget {
  const TxtButton(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(text, style: TextStyle(color: Colors.blue)),
    );
  }
}
