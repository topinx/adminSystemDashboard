import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';

class AccountStatusField extends StatelessWidget {
  const AccountStatusField(this.text, this.menuList,
      {super.key, this.onChanged});

  final String text;

  final List<String> menuList;

  final Function(int)? onChanged;

  Widget buildStatusField(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 240),
        child: LayoutBuilder(builder: (_, constraints) {
          return DropdownBtn(init: 0, menuList: menuList, onChanged: onChanged);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(text)),
          const SizedBox(width: 5),
          Expanded(child: buildStatusField(context)),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class StatusText extends StatelessWidget {
  const StatusText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
        padding: const EdgeInsets.fromLTRB(65, 0, 20, 0),
        alignment: Alignment.centerLeft,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 240),
          alignment: Alignment.centerRight,
          child: Text(text),
        ),
      ),
    );
  }
}
