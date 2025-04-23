import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class InputDrop extends StatelessWidget {
  InputDrop(this.text, this.current, this.items,
      {super.key, required this.onChanged});

  final String text;

  final String current;

  final Future<List<String>> Function(String, LoadProps?)? items;

  final Function(String?) onChanged;

  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Color(0xFFCECECE), width: 1),
  );

  final focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.blue, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: 100, child: Text(text)),
      Expanded(
        child: DropdownSearch<String>(
          items: items,
          key: UniqueKey(),
          selectedItem: current,
          onChanged: onChanged,
          suffixProps: DropdownSuffixProps(
            dropdownButtonProps: DropdownButtonProps(
              iconClosed: Icon(Icons.keyboard_arrow_down),
              iconOpened: Icon(Icons.keyboard_arrow_up),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              constraints: const BoxConstraints(minHeight: 25),
              isDense: true,
              enabledBorder: enableBorder,
              focusedBorder: focusBorder,
            ),
          ),
          popupProps: PopupProps.menu(
            itemBuilder: (context, item, isDisabled, isSelected) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(item, textAlign: TextAlign.center),
              );
            },
            constraints: BoxConstraints(maxHeight: 180),
            menuProps: MenuProps(margin: EdgeInsets.only(top: 12)),
          ),
        ),
      )
    ]);
  }
}
