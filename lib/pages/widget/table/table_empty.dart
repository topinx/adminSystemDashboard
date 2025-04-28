part of 'table_widget.dart';

class TabEmpty extends StatelessWidget {
  const TabEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}

class TabLoading extends StatelessWidget {
  const TabLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Loading());
  }
}

class TabText extends StatelessWidget {
  const TabText(this.text, {super.key});

  final String? text;

  @override
  Widget build(BuildContext context) {
    String string = text ?? "";
    return Text(string.isEmpty ? "-" : string);
  }
}

class TabPlace extends StatelessWidget {
  const TabPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
