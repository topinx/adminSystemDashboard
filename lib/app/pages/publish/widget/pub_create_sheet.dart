import 'package:flutter/material.dart';

class PubCreateSheet extends StatefulWidget {
  const PubCreateSheet({super.key, this.classifyId, required this.createList});

  /// 创意中心分类
  final int? classifyId;

  /// 创意中心分类列表
  final List<String> createList;

  @override
  State<PubCreateSheet> createState() => _PubCreateSheetState();
}

class _PubCreateSheetState extends State<PubCreateSheet> {
  int current = -1;

  @override
  void initState() {
    super.initState();
    if (widget.classifyId == null) {
      current = -1;
    } else {
      current = widget.classifyId!;
    }
  }

  Widget buildTextContent() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("请选择创意中心的分类", style: TextStyle(fontSize: 20)),
      Text("  (${getCurrentCreateText()})",
          style: const TextStyle(fontSize: 12, color: Colors.redAccent)),
    ]);
  }

  String getCreateText(int id) {
    if (id == -1) return "不上传至创意中心";
    if (id == 1) return "教学视频";
    if (id == 2) return "热门视频";

    if (widget.createList.length > id - 3) {
      String text = widget.createList[id - 3];
      if (!text.contains("|")) return text;
      return text.split("|").first;
    }
    return "";
  }

  String getCurrentCreateText() {
    if (current == -1) return "不上传";
    if (current == 1) return "教学视频";
    if (current == 2) return "热门视频";

    if (widget.createList.length > current - 3) {
      String text = widget.createList[current - 3];
      if (!text.contains("|")) return "热门视频-$text";
      return "热门视频-${text.split("|").first}";
    }
    return "";
  }

  void onTapItem(int id) {
    current = id;
    if (mounted) setState(() {});
  }

  Widget buildSelectItem(int id) {
    return Material(
      child: InkWell(
        onTap: () => onTapItem(id),
        child: Ink(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Row(children: [
            Text(getCreateText(id), style: const TextStyle(fontSize: 14)),
            const Spacer(),
            if (id == current) const Icon(Icons.check)
          ]),
        ),
      ),
    );
  }

  Widget buildFirstLevel() {
    return Column(children: [
      buildSelectItem(-1),
      buildSelectItem(1),
      buildSelectItem(2),
    ]);
  }

  Widget buildNextLevel() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: widget.createList.length,
      itemBuilder: (_, i) => buildSelectItem(i + 3),
    );
  }

  void onTapConfirm() {
    Navigator.of(context).pop(current);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      height: 360,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Column(children: [
        buildTextContent(),
        const SizedBox(height: 30),
        Expanded(
          child: Row(children: [
            Expanded(child: buildFirstLevel()),
            if (current >= 2) ...[
              const SizedBox(width: 10),
              Expanded(child: buildNextLevel()),
            ],
          ]),
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: onTapConfirm, child: const Text("确定")),
        const SizedBox(height: 20),
      ]),
    );
  }
}
