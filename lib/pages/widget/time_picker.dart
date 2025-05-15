import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TimePicker extends StatefulWidget {
  const TimePicker(
    this.offset, {
    super.key,
    this.rangeMode = false,
    this.rangeStart,
    this.rangeEnd,
  });

  final Offset offset;

  final bool rangeMode;

  final DateTime? rangeStart;

  final DateTime? rangeEnd;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker>
    with SingleTickerProviderStateMixin {
  late AnimationController anim;
  late Animation<double> animation;

  DateTime? rangeStart;
  DateTime? rangeEnd;

  @override
  void didUpdateWidget(covariant TimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    rangeStart = widget.rangeStart;
    rangeEnd = widget.rangeEnd;
  }

  @override
  void initState() {
    super.initState();
    anim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    animation = Tween<double>(begin: 0, end: 280).animate(
      CurvedAnimation(parent: anim, curve: Curves.easeOut),
    );

    rangeStart = widget.rangeStart;
    rangeEnd = widget.rangeEnd;

    WidgetsBinding.instance.addPostFrameCallback((_) => anim.forward());
  }

  @override
  void dispose() {
    super.dispose();
    anim.dispose();
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs? selection) {
    if (!widget.rangeMode) {
      Navigator.of(context).pop(selection?.value);
    } else {
      if (selection?.value == null) return;
      if (selection!.value is PickerDateRange) {
        PickerDateRange range = selection.value;
        rangeStart = range.startDate;
        rangeEnd = range.endDate;
      }
    }
  }

  void onTapClear() {
    Navigator.of(context).pop({"start": null, "end": null});
  }

  void onTapConfirm(data) {
    Navigator.of(context).pop({"start": rangeStart, "end": rangeEnd});
  }

  Widget buildPickerContent(BuildContext context) {
    return SfDateRangePicker(
      selectionMode: widget.rangeMode
          ? DateRangePickerSelectionMode.range
          : DateRangePickerSelectionMode.single,
      enableMultiView: widget.rangeMode,
      view: DateRangePickerView.month,
      confirmText: "确定",
      cancelText: "清除",
      onSelectionChanged: onSelectionChanged,
      onSubmit: onTapConfirm,
      onCancel: onTapClear,
      showActionButtons: widget.rangeMode,
      backgroundColor: Theme.of(context).canvasColor,
      navigationDirection: DateRangePickerNavigationDirection.horizontal,
      selectionColor: Colors.blue,
      headerStyle: DateRangePickerHeaderStyle(
        textAlign: TextAlign.center,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      selectionShape: DateRangePickerSelectionShape.circle,
      initialSelectedRange: widget.rangeStart == null
          ? null
          : PickerDateRange(widget.rangeStart, widget.rangeEnd),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.antiAlias, children: [
      Positioned(
        left: widget.offset.dx,
        top: widget.offset.dy,
        child: AnimatedBuilder(
          animation: anim,
          builder: (_, child) => Container(
            height: animation.value,
            child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: 280,
                  width: widget.rangeMode ? 480 : 240,
                  child: buildPickerContent(context),
                )),
          ),
        ),
      )
    ]);
  }
}
