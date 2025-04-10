import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';

import '../controller/publish_controller.dart';

class PubPosition extends StatefulWidget {
  const PubPosition(this.ctr, {super.key});

  final PublishController ctr;

  @override
  State<PubPosition> createState() => _PubPositionState();
}

class _PubPositionState extends State<PubPosition> {
  List positions = [];

  @override
  void initState() {
    super.initState();
    readPositionJson();
  }

  void readPositionJson() async {
    String data = await rootBundle.loadString("assets/region.json");
    positions = json.decode(data);
    if (mounted) setState(() {});
  }

  void onChanged(int i) {
    if (i == 0) {
      widget.ctr.detail.location = "";
      widget.ctr.detail.position = "";
    } else {
      var data = positions[i - 1];
      widget.ctr.detail.location = data["location"];
      widget.ctr.detail.position = jsonEncode(data["position"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);

    List<String> menuList = positions.map((x) => x["name"].toString()).toList();
    menuList.insert(0, "不设置位置");

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 36,
        width: 80,
        alignment: Alignment.centerLeft,
        child: Text("发布地点：", style: textStyle),
      ),
      DropdownBtn(
        width: 320,
        height: 36,
        init: 0,
        selectedItemBuilder: (_) => List.generate(
          menuList.length,
          (i) => Center(child: Text(menuList[i], style: textStyle)),
        ),
        onChanged: onChanged,
        menuList: menuList,
      ),
    ]);
  }
}
