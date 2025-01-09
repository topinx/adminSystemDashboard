import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';

class PubDropUser extends StatelessWidget {
  const PubDropUser({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("发布用户：", style: textStyle),
      ),
      DropdownBtn(
          width: 180,
          height: 36,
          init: 0,
          selectedItemBuilder: (_) => [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: Text("mm-000", style: textStyle)),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: Text("mm-001", style: textStyle)),
              ],
          onChanged: (_) {},
          menuList: const ["mm-000", "mm-001"])
    ]);
  }
}
