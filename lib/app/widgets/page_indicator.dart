import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';

class PageIndicator extends StatefulWidget {
  const PageIndicator({super.key, required this.itemCount});

  final int itemCount;

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  TextEditingController inputCtr = TextEditingController();

  int pageSize = 10;
  int maxPage = 1;
  int curPage = 1;

  @override
  void initState() {
    super.initState();
    maxPage = (widget.itemCount / pageSize).ceil();
    maxPage = maxPage == 0 ? 1 : maxPage;
    inputCtr.text = "$curPage";
  }

  @override
  void didUpdateWidget(covariant PageIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    maxPage = (widget.itemCount / pageSize).ceil();
    maxPage = maxPage == 0 ? 1 : maxPage;
  }

  @override
  void dispose() {
    super.dispose();
    inputCtr.dispose();
  }

  void onPageSizeChanged(int index) {
    int size = [10, 20, 50][index];
    if (pageSize == size) return;
    pageSize = size;
    curPage = 1;
    maxPage = (widget.itemCount / pageSize).ceil();
    maxPage = maxPage == 0 ? 1 : maxPage;
    inputCtr.text = "$curPage";
    if (mounted) setState(() {});
  }

  void onTapPage(int page) {
    if (curPage == page) return;
    curPage = page;
    inputCtr.text = "$curPage";
    if (mounted) setState(() {});
  }

  void onTapNext() {
    curPage += 1;
    inputCtr.text = "$curPage";
    if (mounted) setState(() {});
  }

  void onTapPrevious() {
    curPage -= 1;
    inputCtr.text = "$curPage";
    if (mounted) setState(() {});
  }

  Widget buildJumpInput() {
    return Container(
      height: 32,
      width: 60,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        controller: inputCtr,
        onSubmitted: (string) {
          int number = int.tryParse(string) ?? 0;
          if (number == 0) {
            inputCtr.text = "1";
          }
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign: TextAlign.center,
      ),
    );
  }

  List<Widget> indicatorList() {
    if (maxPage == 1) {
      return [IndicatorNum(1, curPage == 1, onTapPage)];
    }
    if (maxPage <= 6) {
      return List.generate(maxPage, (i) {
        return IndicatorNum(i + 1, curPage == i + 1, onTapPage);
      });
    }
    if (curPage > maxPage - 5) {
      return [
        IndicatorNum(1, curPage == 1, onTapPage),
        const IndicatorDot(),
        ...List.generate(6, (i) {
          int page = maxPage - 6 + i + 1;
          return IndicatorNum(page, curPage == page, onTapPage);
        }),
      ];
    }
    return [
      ...List.generate(5, (i) {
        int page = curPage > 2 ? curPage - 3 + i + 1 : i + 1;
        return IndicatorNum(page, curPage == page, onTapPage);
      }),
      const IndicatorDot(),
      IndicatorNum(maxPage, curPage == maxPage, onTapPage),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      height: 40,
      child: Row(children: [
        Text("共${widget.itemCount}条"),
        const Spacer(),
        DropdownBtn(
          height: 32,
          width: 80,
          onChanged: onPageSizeChanged,
          init: 0,
          selectedItemBuilder: (_) => const [
            Center(child: Text("10条/页", style: TextStyle(fontSize: 12))),
            Center(child: Text("20条/页", style: TextStyle(fontSize: 12))),
            Center(child: Text("50条/页", style: TextStyle(fontSize: 12))),
          ],
          menuList: const ["10", "20", "50"],
        ),
        const SizedBox(width: 2),
        IndicatorPN(false, curPage != 1, onTapPrevious),
        ...indicatorList(),
        IndicatorPN(true, curPage != maxPage, onTapNext),
        const SizedBox(width: 10),
        const Text("前往"),
        const SizedBox(width: 4),
        buildJumpInput(),
        const SizedBox(width: 4),
        const Text("页"),
      ]),
    );
  }
}

class IndicatorNum extends StatelessWidget {
  const IndicatorNum(this.number, this.active, this.onTap, {super.key});

  final int number;

  final bool active;

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    Color color = active ? const Color(0xFF3871BB) : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
          minimumSize: const Size.square(40),
          maximumSize: const Size.square(40),
          padding: EdgeInsets.zero,
        ),
        onPressed: () => onTap(number),
        child: Text("$number", style: TextStyle(color: color)),
      ),
    );
  }
}

class IndicatorPN extends StatelessWidget {
  const IndicatorPN(this.isNext, this.active, this.onTap, {super.key});

  final bool isNext;

  final bool active;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
          minimumSize: const Size.square(40),
          maximumSize: const Size.square(40),
          padding: EdgeInsets.zero,
        ),
        onPressed: active ? onTap : null,
        child: isNext
            ? const Icon(Icons.keyboard_arrow_right, color: Colors.black12)
            : const Icon(Icons.keyboard_arrow_left, color: Colors.black12),
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  const IndicatorDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          side: const BorderSide(color: Colors.transparent, width: 1),
          minimumSize: const Size.square(40),
          maximumSize: const Size.square(40),
          padding: EdgeInsets.zero,
        ),
        onPressed: null,
        child: const Text("···"),
      ),
    );
  }
}
