part of 'async_table.dart';

class AsyncEmpty extends StatelessWidget {
  const AsyncEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFFEBEBEB),
        ),
        child: Text("暂无数据"),
      ),
    );
  }
}

class AsyncLoading extends StatelessWidget {
  const AsyncLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Loading());
  }
}

class AsyncText extends StatelessWidget {
  const AsyncText(this.text, {super.key});

  final String? text;

  @override
  Widget build(BuildContext context) {
    String string = text ?? "";
    return Text(string.isEmpty ? "-" : string, maxLines: 1);
  }
}

class AsyncImage extends StatelessWidget {
  const AsyncImage(this.path, {super.key});

  final String? path;

  @override
  Widget build(BuildContext context) {
    String string = path ?? "";
    if (string.isEmpty) {
      return const SizedBox();
    }

    return Container(
      height: 56,
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Image.network(
        AppConstants.assetsLink + path,
        headers: {"Authorization": AppConstants.signToken()},
        errorBuilder: (_, er, __) =>
            Icon(Icons.error_outline, color: Colors.grey),
      ),
    );
  }
}
