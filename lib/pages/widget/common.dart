import 'package:flutter/material.dart';

class CommonError extends StatelessWidget {
  const CommonError(this.error, {super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black12,
      child: Text(error.toString()),
    );
  }
}

class CommonLoading extends StatelessWidget {
  const CommonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black12,
      child: const Loading(),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xFFEBEBEB),
      ),
      child: SizedBox.square(
        dimension: 30,
        child: CircularProgressIndicator(color: Colors.blue),
      ),
    );
  }
}
