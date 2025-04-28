part of 'table_widget.dart';

class TableIndicator extends StatefulWidget {
  const TableIndicator(this.ctr, {super.key});

  final PaginatorController ctr;

  @override
  State<TableIndicator> createState() => _TableIndicatorState();
}

class _TableIndicatorState extends State<TableIndicator> {
  int max = 1;
  int cur = 1;

  @override
  void initState() {
    super.initState();
    widget.ctr.addListener(update);

    cur =
        1 + ((widget.ctr.currentRowIndex + 1) / widget.ctr.rowsPerPage).floor();
    max = (widget.ctr.rowCount / widget.ctr.rowsPerPage).ceil();
  }

  @override
  void didUpdateWidget(covariant TableIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    cur =
        1 + ((widget.ctr.currentRowIndex + 1) / widget.ctr.rowsPerPage).floor();
    max = (widget.ctr.rowCount / widget.ctr.rowsPerPage).ceil();
  }

  @override
  void dispose() {
    widget.ctr.removeListener(update);
    super.dispose();
  }

  void update() {
    if (mounted) setState(() {});
  }

  void onTapP() {
    widget.ctr.goToPreviousPage();
  }

  void onTapN() {
    widget.ctr.goToNextPage();
  }

  void onTapNum(int n) {
    widget.ctr.goToPageWithRow((n - 1) & widget.ctr.rowsPerPage);
  }

  List<Widget> indicatorList() {
    if (max == 1) {
      return [Indicator.Num(1, cur == 1, onTap: () => onTapNum(1))];
    }
    if (max <= 6) {
      return List.generate(max, (i) {
        return Indicator.Num(i + 1, cur == i + 1, onTap: () => onTapNum(i + 1));
      });
    }
    if (cur > max - 5) {
      return [
        Indicator.Num(1, cur == 1, onTap: () => onTapNum(1)),
        Indicator.Dot(),
        ...List.generate(6, (i) {
          int page = max - 6 + i + 1;
          return Indicator.Num(page, cur == page, onTap: () => onTapNum(page));
        }),
      ];
    }
    return [
      ...List.generate(5, (i) {
        int page = cur > 2 ? cur - 3 + i + 1 : i + 1;
        return Indicator.Num(page, cur == page, onTap: () => onTapNum(page));
      }),
      Indicator.Dot(),
      Indicator.Num(max, cur == max, onTap: () => onTapNum(max)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.ctr.isAttached) return const SizedBox();

    return Row(children: [
      const SizedBox(width: 16),
      Text("共${widget.ctr.rowCount}条"),
      const Spacer(),
      Indicator.BtnP(cur != 1, onTap: onTapP),
      ...indicatorList(),
      Indicator.BtnN(cur != max, onTap: onTapN),
      const SizedBox(width: 16),
    ]);
  }
}

class Indicator extends StatelessWidget {
  Indicator.BtnN(this.active, {this.onTap})
      : child = Icon(Icons.keyboard_arrow_right, color: Colors.black12);

  Indicator.BtnP(this.active, {this.onTap})
      : child = Icon(Icons.keyboard_arrow_left, color: Colors.black12);

  Indicator.Num(int num, this.active, {this.onTap})
      : child = Text("$num",
            style: TextStyle(color: active ? Colors.black : Colors.black45));

  Indicator.Dot({this.onTap})
      : active = false,
        child = Text("···", style: TextStyle(color: Colors.black45));

  final Widget child;

  final bool active;

  final Function()? onTap;

  final style = OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
    minimumSize: const Size.square(40),
    maximumSize: const Size.square(40),
    padding: EdgeInsets.zero,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: OutlinedButton(
        style: style,
        onPressed: active ? onTap : null,
        child: child,
      ),
    );
  }
}
