import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/contants/app_constants.dart';

import 'preview_dialog.dart';

class TableList extends StatefulWidget {
  const TableList({
    super.key,
    required this.titleList,
    required this.itemCount,
    required this.builder,
    this.flexList,
    this.onReorder,
    this.onSelect,
    this.enableOrder,
  }) : assert(flexList == null || flexList.length == titleList.length);

  final List<int>? flexList;

  final List<String> titleList;

  final int itemCount;

  final Widget Function(int, int) builder;

  final bool? enableOrder;

  final Function(int, int)? onReorder;

  final Function(List<int>)? onSelect;

  @override
  State<TableList> createState() => TableListState();
}

class TableListState extends State<TableList> {
  List<int> flexList = [];

  List<int> selectList = [];

  @override
  void initState() {
    super.initState();
    flexList = widget.flexList ?? List.filled(widget.titleList.length, 1);
  }

  @override
  void didUpdateWidget(covariant TableList oldWidget) {
    super.didUpdateWidget(oldWidget);
    flexList = widget.flexList ?? List.filled(widget.titleList.length, 1);
    selectList.clear();
    if (widget.onSelect != null) widget.onSelect!(selectList);
  }

  void _onTapSelectAll() {
    if (selectList.length == widget.itemCount) {
      selectList.clear();
    } else {
      selectList = List.generate(widget.itemCount, (i) => i);
    }
    if (widget.onSelect != null) widget.onSelect!(selectList);

    if (mounted) setState(() {});
  }

  void _onTapSelectItem(int i) {
    if (selectList.contains(i)) {
      selectList.remove(i);
    } else {
      selectList.add(i);
    }
    if (widget.onSelect != null) widget.onSelect!(selectList);

    if (mounted) setState(() {});
  }

  void _onTableListReorder(int oldIndex, int newIndex) {
    if (widget.onReorder == null) return;
    if (newIndex > oldIndex) newIndex -= 1;
    widget.onReorder!(oldIndex, newIndex);
    if (mounted) setState(() {});
  }

  Widget _buildTableTitle(BuildContext context) {
    List<Widget> titleContent = List.generate(
      widget.titleList.length,
      (i) => Expanded(
        flex: flexList[i],
        child: Center(child: Text(widget.titleList[i], maxLines: 1)),
      ),
    );

    Widget? prefix;
    if (widget.onReorder != null && widget.enableOrder == true) {
      prefix = null;
    } else if (widget.onSelect != null) {
      bool active =
          selectList.length == widget.itemCount && selectList.isNotEmpty;
      bool contain = selectList.isNotEmpty;

      prefix = PrefixCheck(active, contain, onTap: _onTapSelectAll);
    }

    return Container(
      height: 60,
      color: Colors.black12,
      child: Row(children: [if (prefix != null) prefix, ...titleContent]),
    );
  }

  Widget _buildContentItem(int i) {
    List<Widget> itemContent = List.generate(
      widget.titleList.length,
      (index) =>
          Expanded(flex: flexList[index], child: widget.builder(i, index)),
    );

    Widget? prefix;
    if (widget.onReorder != null && widget.enableOrder == true) {
      prefix = PrefixDrag(index: i);
    } else if (widget.onSelect != null) {
      bool active = selectList.contains(i);
      prefix = PrefixCheck(active, false, onTap: () => _onTapSelectItem(i));
    }

    return Container(
      height: 50,
      key: ValueKey(i),
      color: Colors.transparent,
      child: Row(children: [if (prefix != null) prefix, ...itemContent]),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget tableList = ReorderableList(
      itemBuilder: (_, i) => _buildContentItem(i),
      itemCount: widget.itemCount,
      itemExtent: 50,
      onReorder: _onTableListReorder,
    );

    Widget tableContent = Column(
        children: [_buildTableTitle(context), Expanded(child: tableList)]);

    return LayoutBuilder(builder: (_, constraints) {
      return SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: constraints.maxWidth <= 640 ? 640 : constraints.maxWidth,
          child: tableContent,
        ),
      );
    });
  }
}

class PrefixCheck extends StatelessWidget {
  const PrefixCheck(this.active, this.contain, {super.key, this.onTap});

  final bool active;

  final bool contain;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    IconData iconData = active
        ? Icons.check_box_outlined
        : (contain
            ? Icons.indeterminate_check_box_outlined
            : Icons.check_box_outline_blank);

    Color iconColor =
        active || contain ? const Color(0xFF3871BB) : Colors.black12;

    return IconButton(
      onPressed: onTap,
      icon: Icon(iconData, color: iconColor),
    );
  }
}

class PrefixDrag extends StatelessWidget {
  const PrefixDrag({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      index: index,
      child: const IconButton(
        onPressed: null,
        icon: Icon(Icons.drag_handle, color: Colors.black12),
      ),
    );
  }
}

class TableListText extends StatelessWidget {
  const TableListText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Center(
        child: Text(text.isEmpty ? "--" : text,
            maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

class TableListCover extends StatelessWidget {
  const TableListCover(this.cover, {super.key});

  final String cover;

  void onTapCover(String cover, int type) {
    Get.dialog(PreviewDialog(data: cover, type: type));
  }

  @override
  Widget build(BuildContext context) {
    DecorationImage? image;
    if (cover.isNotEmpty) {
      image = DecorationImage(
          image: NetworkImage(
        AppConstants.assetsLink + cover,
        headers: {"Authorization": AppConstants.signToken()},
      ));
    }

    return GestureDetector(
      onTap: () => onTapCover(cover, 1),
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 50,
        decoration: BoxDecoration(image: image),
      ),
    );
  }
}

class TableListCheck extends StatelessWidget {
  const TableListCheck({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onTap,
        child: const Text("查看详情", style: TextStyle(color: Color(0xFF3871BB))),
      ),
    );
  }
}

class TableListBtn extends StatelessWidget {
  const TableListBtn(this.buttons, {super.key});

  final Map<String, Function()?> buttons;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(right: 30),
      reverse: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, i) => Center(
        child: TextButton(
          onPressed: buttons.values.toList()[i],
          child: Text(
            buttons.keys.toList()[i],
            style: const TextStyle(color: Color(0xFF3871BB)),
          ),
        ),
      ),
      itemCount: buttons.length,
    );
  }
}
