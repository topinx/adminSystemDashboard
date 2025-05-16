import 'package:flutter/cupertino.dart';

class SearchSortSwitch extends StatelessWidget {
  const SearchSortSwitch(this.isAuto, {super.key, required this.onChanged});

  final bool isAuto;

  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: 80, child: Text("自动排序:")),
      SizedBox(
        height: 30,
        child: FittedBox(
          fit: BoxFit.contain,
          child: CupertinoSwitch(value: isAuto, onChanged: onChanged),
        ),
      ),
    ]);
  }
}
