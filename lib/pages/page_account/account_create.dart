import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_back/bean/bean_image.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/util/utils.dart';

import 'provider/account_create_provider.dart';
import 'widget/user_image.dart';
import 'widget/user_txt_title.dart';

class AccountCreate extends ConsumerStatefulWidget {
  const AccountCreate({super.key});

  @override
  ConsumerState<AccountCreate> createState() => _AccountCreateState();
}

class _AccountCreateState extends ConsumerState<AccountCreate> {
  GlobalKey<FormState> formKey = GlobalKey();

  void onTapCreate() {}

  void onPickAvatar() async {
    List<XMLImage> files = await Utils.pickFile();
    if (files.isEmpty) return;

    var crop = await Utils.onCropImage(files.first);
    if (crop == null) return;

    files.first.bytes = crop;
    ref
        .read(userCreateProvider.notifier)
        .updateAvatar(BeanImage("", files.first));
  }

  Widget buildCreateContent() {
    var create = ref.watch(userCreateProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          UserTxtTitle("用户头像："),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: UserImage(image: create.avatar, onPick: onPickAvatar),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).canvasColor,
      ),
      child: Column(children: [
        Row(children: [
          PopButton(),
          const Spacer(),
          ElvButton("创建", onTap: onTapCreate),
        ]),
        const SizedBox(height: 20),
        Expanded(child: buildCreateContent())
      ]),
    );
  }
}
