import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class UserEditDrop extends StatelessWidget {
  UserEditDrop(
    this.current,
    this.items, {
    super.key,
    required this.onChanged,
    required this.enable,
  });

  final String current;

  final bool enable;

  final Future<List<String>> Function(String, LoadProps?)? items;

  final Function(String?) onChanged;

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
    Color color = enable ? Colors.blue : Colors.black;

    return DropdownSearch<String>(
      items: items,
      enabled: enable,
      key: UniqueKey(),
      selectedItem: current,
      onChanged: onChanged,
      suffixProps: DropdownSuffixProps(
        dropdownButtonProps:
            DropdownButtonProps(iconClosed: SizedBox(), iconOpened: SizedBox()),
      ),
      decoratorProps: DropDownDecoratorProps(
        textAlign: TextAlign.start,
        baseStyle: TextStyle(color: color, fontSize: 14),
        decoration: InputDecoration(
          isDense: true,
          suffixIconConstraints: BoxConstraints(maxHeight: 0),
          constraints: const BoxConstraints(maxWidth: 200),
          contentPadding: const EdgeInsets.all(10),
          disabledBorder: disableBorder,
          enabledBorder: enableBorder,
          focusedBorder: enableBorder,
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
    );
  }
}
