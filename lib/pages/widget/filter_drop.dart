import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:top_back/pages/widget/time_picker.dart';
import 'package:top_back/util/utils.dart';

class FilterDrop extends StatelessWidget {
  FilterDrop(this.text, this.current, this.items,
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
      SizedBox(width: 80, child: Text("$text:")),
      SizedBox(
        width: 120,
        child: DropdownSearch<String>(
          items: items,
          key: UniqueKey(),
          selectedItem: current,
          onChanged: onChanged,
          suffixProps: DropdownSuffixProps(
            dropdownButtonProps: DropdownButtonProps(
              padding: EdgeInsets.zero,
              iconClosed: Icon(Icons.keyboard_arrow_down, size: 20),
              iconOpened: Icon(Icons.keyboard_arrow_up, size: 20),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              constraints: const BoxConstraints(minHeight: 25),
              isDense: true,
              suffixIconConstraints: const BoxConstraints(maxHeight: 25),
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

class FilterTime extends StatefulWidget {
  const FilterTime(this.text,
      {super.key, this.start, this.end, this.onChanged});

  final String text;

  final String? start;

  final String? end;

  final Function(String, String)? onChanged;

  @override
  State<FilterTime> createState() => _FilterTimeState();
}

class _FilterTimeState extends State<FilterTime> {
  DateTime? timeStart;
  DateTime? timeEnd;

  @override
  void initState() {
    super.initState();
    String stringTimeStart = widget.start ?? "";
    if (Utils.isDateTime(stringTimeStart)) {
      timeStart = DateTime.tryParse(stringTimeStart);
    }
    String stringEndStart = widget.end ?? "";
    if (Utils.isDateTime(stringEndStart)) {
      timeEnd = DateTime.tryParse(stringEndStart);
    }
  }

  @override
  void didUpdateWidget(covariant FilterTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    String stringTimeStart = widget.start ?? "";
    if (Utils.isDateTime(stringTimeStart)) {
      timeStart = DateTime.tryParse(stringTimeStart);
    }
    String stringEndStart = widget.end ?? "";
    if (Utils.isDateTime(stringEndStart)) {
      timeEnd = DateTime.tryParse(stringEndStart);
    }
  }

  String get timeS =>
      timeStart == null ? "起始时间" : timeStart.toString().substring(0, 10);
  String get timeE =>
      timeEnd == null ? "终止时间" : timeEnd.toString().substring(0, 10);

  void onTapPicker(bool isStart) async {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    Offset offset = Offset(position.dx - 140, position.dy + 46);

    var date = await showDialog(
      context: context,
      builder: (_) => Center(
        child: TimePicker(
          offset,
          rangeMode: true,
          rangeStart: timeStart,
          rangeEnd: timeEnd,
        ),
      ),
    );
    if (date == null) return;

    DateTime? s = date["start"];
    DateTime? e = date["end"];
    if (s != null && e == null) {
      if (isStart) {
        timeStart = s;
      } else {
        timeEnd = s;
      }
      onChanged();
      if (mounted) setState(() {});
    } else {
      timeStart = s;
      timeEnd = e;
      onChanged();
      if (mounted) setState(() {});
    }
  }

  void onChanged() {
    if (widget.onChanged == null) return;
    String stringS =
        timeStart == null ? "" : timeStart.toString().substring(0, 19);
    String stringE = timeEnd == null ? "" : timeEnd.toString().substring(0, 19);
    widget.onChanged!(stringS, stringE);
  }

  Widget buildTimeDrop(String text, bool isStart) {
    return OutlinedButton(
      onPressed: () => onTapPicker(isStart),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        fixedSize: const Size(120, 36),
        side: BorderSide(color: Color(0xFFCECECE), width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(text, style: TextStyle(color: Colors.black)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: 80, child: Text("${widget.text}:")),
      buildTimeDrop(timeS, true),
      const SizedBox(width: 5),
      Text("~"),
      const SizedBox(width: 5),
      buildTimeDrop(timeE, false),
    ]);
  }
}
