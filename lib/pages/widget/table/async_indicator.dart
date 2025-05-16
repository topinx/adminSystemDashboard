part of 'async_table.dart';

class AsyncIndicator extends StatelessWidget {
  const AsyncIndicator({
    super.key,
    required this.onTap,
    required this.cur,
    required this.dataLen,
    required this.pageLen,
  });

  final int cur;

  final int dataLen;

  final int pageLen;

  final Function(int) onTap;

  List<Widget> indicatorList() {
    if (pageLen == 1) {
      return [Indicator.Num(1, cur == 1, onTap: () => onTap(1))];
    }
    if (pageLen <= 6) {
      return List.generate(pageLen, (i) {
        return Indicator.Num(i + 1, cur == i + 1, onTap: () => onTap(i + 1));
      });
    }
    if (cur > pageLen - 5) {
      return [
        Indicator.Num(1, cur == 1, onTap: () => onTap(1)),
        Indicator.Dot(),
        ...List.generate(6, (i) {
          int page = pageLen - 6 + i + 1;
          return Indicator.Num(page, cur == page, onTap: () => onTap(page));
        }),
      ];
    }
    return [
      ...List.generate(5, (i) {
        int page = cur > 2 ? cur - 3 + i + 1 : i + 1;
        return Indicator.Num(page, cur == page, onTap: () => onTap(page));
      }),
      Indicator.Dot(),
      Indicator.Num(pageLen, cur == pageLen, onTap: () => onTap(pageLen)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(width: 16),
      Text("共$dataLen条"),
      const Spacer(),
      Indicator.BtnP(cur != 1, onTap: () => onTap(cur - 1)),
      ...indicatorList(),
      Indicator.BtnN(cur != pageLen, onTap: () => onTap(cur + 1)),
      const SizedBox(width: 16),
    ]);
  }
}

class Indicator extends StatelessWidget {
  Indicator.BtnN(this.active, {this.onTap})
      : child = Icon(Icons.keyboard_arrow_right, color: Colors.black12);

  Indicator.BtnP(this.active, {this.onTap})
      : child = Icon(Icons.keyboard_arrow_left, color: Colors.black12);

  Indicator.Num(int num, bool same, {this.onTap})
      : this.active = true,
        child = Text("$num",
            style: TextStyle(color: same ? Colors.black : Colors.black45));

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
