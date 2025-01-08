import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/responsive_widget.dart';

class AccountInfoPhone extends StatefulWidget {
  const AccountInfoPhone(
      {super.key,
      required this.ctr,
      this.enable,
      required this.areaCode,
      required this.onChange});

  final String areaCode;

  final TextEditingController ctr;

  final bool? enable;

  final Function(String) onChange;

  @override
  State<AccountInfoPhone> createState() => _AccountInfoPhoneState();
}

class _AccountInfoPhoneState extends State<AccountInfoPhone> {
  String phoneCode = "";

  @override
  void initState() {
    super.initState();
    phoneCode = widget.areaCode;
  }

  @override
  void didUpdateWidget(covariant AccountInfoPhone oldWidget) {
    super.didUpdateWidget(oldWidget);
    phoneCode = widget.areaCode;
  }

  void onTapAreaCode() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: const CountryListThemeData(
        bottomSheetWidth: kMobileToTable,
        bottomSheetHeight: 600,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      onSelect: (Country country) {
        phoneCode = "+${country.phoneCode}";
        if (mounted) setState(() {});
        widget.onChange(phoneCode);
      },
    );
  }

  Widget buildTextField(BuildContext context) {
    return TextField(
      enabled: widget.enable ?? false,
      controller: widget.ctr,
      style: const TextStyle(color: Colors.black, fontSize: 14),
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxHeight: 25, maxWidth: 240),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        prefixIcon: GestureDetector(
          onTap: onTapAreaCode,
          child: Container(
            width: 45,
            margin: const EdgeInsets.only(left: 10),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(phoneCode),
                const Icon(Icons.arrow_drop_down, size: 12),
              ],
            ),
          ),
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
        const SizedBox(width: 60, child: Text("绑定手机")),
        const Text(":"),
        buildTextField(context),
      ]),
    );
  }
}
