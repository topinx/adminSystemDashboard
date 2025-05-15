import 'package:flutter/material.dart';

import 'countries.dart';

class PhoneCodeSheet extends StatefulWidget {
  const PhoneCodeSheet({super.key});

  @override
  State<PhoneCodeSheet> createState() => _PhoneCodeSheetState();
}

class _PhoneCodeSheetState extends State<PhoneCodeSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController anim;

  late Animation<Offset> animation;

  TextEditingController controller = TextEditingController();

  final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.blue));

  List<Map<String, String>> countryList = [];

  @override
  void initState() {
    super.initState();
    anim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation = Tween(begin: Offset(-600, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: anim, curve: Curves.linear));

    countryList.clear();
    countryList.addAll(countries);

    WidgetsBinding.instance.addPostFrameCallback((_) => anim.forward());
  }

  @override
  void dispose() {
    super.dispose();
    anim.dispose();
    controller.dispose();
  }

  void onInputChanged(String string) {
    String input = string.trimLeft().toUpperCase();

    if (input.isEmpty) {
      countryList.clear();
      countryList.addAll(countries);
    } else {
      countryList.clear();
      countryList
          .addAll(countries.where((x) => containSearch(input, x)).toList());
    }

    if (mounted) setState(() {});
  }

  bool containSearch(String input, data) {
    if (input.startsWith("+")) {
      input = input.replaceFirst("+", "").trim();
    }
    return data["phone_code"].startsWith(input.toUpperCase()) ||
        data["country_code"].toUpperCase().startsWith(input.toUpperCase()) ||
        data["name"].toUpperCase().startsWith(input.toUpperCase());
  }

  Widget buildSearchInput() {
    return TextField(
      style: TextStyle(fontSize: 14),
      onChanged: onInputChanged,
      controller: controller,
      decoration: InputDecoration(
        border: inputBorder,
        isDense: true,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
      ),
    );
  }

  Widget buildCountryList() {
    return ListView.builder(
      itemExtent: 40,
      itemBuilder: (_, i) => CountryItem(countryList[i]),
      itemCount: countryList.length,
      padding: EdgeInsets.zero,
    );
  }

  Widget buildCodeContent() {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 300,
        height: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: Column(children: [
          buildSearchInput(),
          const SizedBox(height: 20),
          Expanded(child: buildCountryList()),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        right: 0,
        top: 0,
        bottom: 0,
        child: AnimatedBuilder(
          animation: anim,
          builder: (_, child) => SlideTransition(
            position: animation,
            child: child,
          ),
          child: buildCodeContent(),
        ),
      )
    ]);
  }
}

class CountryItem extends StatelessWidget {
  const CountryItem(this.data, {super.key});

  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    final int firstLetter =
        data["country_code"]!.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter =
        data["country_code"]!.codeUnitAt(1) - 0x41 + 0x1F1E6;
    String emoji =
        String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(data["phone_code"]),
        child: Ink(
          color: Colors.transparent,
          child: Row(children: [
            SizedBox(
              width: 40,
              child: Text(emoji, style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 5),
            Text("+ ${data["phone_code"]}", style: TextStyle(fontSize: 14)),
            const SizedBox(width: 15),
            Expanded(
              child: Text(data["name"] ?? "",
                  maxLines: 1, style: TextStyle(fontSize: 14)),
            )
          ]),
        ),
      ),
    );
  }
}
