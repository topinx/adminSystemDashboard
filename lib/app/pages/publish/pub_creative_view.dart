import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/view_container.dart';
import 'controller/pub_creative_controller.dart';

class PubCreativeView extends StatefulWidget {
  const PubCreativeView({super.key});

  @override
  State<PubCreativeView> createState() => _PubCreativeViewState();
}

class _PubCreativeViewState extends State<PubCreativeView> {
  final PubCreativeController ctr = Get.find<PubCreativeController>();

  @override
  Widget build(BuildContext context) {
    return const ViewContainer();
  }
}
