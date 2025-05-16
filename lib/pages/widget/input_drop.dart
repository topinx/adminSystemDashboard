import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class InputDrop extends StatelessWidget {
  InputDrop(
    this.current,
    this.items, {
    super.key,
    required this.onChanged,
    this.enable = true,
    this.hint = "",
    this.defBorder,
    this.showSearch = false,
    this.style,
    this.maxWidth = 200,
    this.validator,
  });

  final String current;

  final bool enable;

  final Future<List<String>> Function(String, LoadProps?)? items;

  final Function(String?) onChanged;

  final String hint;

  final OutlineInputBorder? defBorder;

  final bool showSearch;

  final TextStyle? style;

  final double maxWidth;

  final String? Function(String?)? validator;

  final disableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Color(0xFFE5E5E5), width: 1),
  );

  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.blue, width: 1),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.redAccent, width: 1),
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
      validator: validator,
      suffixProps: DropdownSuffixProps(
        dropdownButtonProps:
            DropdownButtonProps(iconClosed: SizedBox(), iconOpened: SizedBox()),
      ),
      decoratorProps: DropDownDecoratorProps(
        textAlign: TextAlign.start,
        baseStyle: style ?? TextStyle(color: color, fontSize: 14),
        decoration: InputDecoration(
          isDense: true,
          suffixIconConstraints: BoxConstraints(maxHeight: 0),
          constraints: BoxConstraints(maxWidth: maxWidth),
          contentPadding: const EdgeInsets.all(10),
          disabledBorder: disableBorder,
          enabledBorder: defBorder ?? enableBorder,
          focusedBorder: enableBorder,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
        ),
      ),
      popupProps: PopupProps.menu(
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            enabledBorder: disableBorder,
            focusedBorder: enableBorder,
            hintStyle: TextStyle(color: Color(0xFFE5E5E5), fontSize: 14),
            contentPadding: const EdgeInsets.all(10),
          ),
        ),
        loadingBuilder: (_, __) => Center(
          child: SizedBox.square(
            dimension: 20,
            child:
                CircularProgressIndicator(color: Colors.blue, strokeWidth: 2),
          ),
        ),
        showSearchBox: showSearch,
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
