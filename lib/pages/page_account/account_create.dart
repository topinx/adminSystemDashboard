import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_back/bean/bean_image.dart';
import 'package:top_back/constants/app_constants.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/toast/toast.dart';
import 'package:top_back/util/utils.dart';

import 'provider/account_create_provider.dart';
import 'widget/user_edit_drop.dart';
import 'widget/user_edit_input.dart';
import 'widget/user_image.dart';
import 'widget/user_txt_title.dart';

class AccountCreate extends ConsumerStatefulWidget {
  const AccountCreate({super.key});

  @override
  ConsumerState<AccountCreate> createState() => _AccountCreateState();
}

class _AccountCreateState extends ConsumerState<AccountCreate> {
  GlobalKey<FormState> formKey = GlobalKey();

  final stateList1 = ["选择", "男", "女"];

  TextEditingController inputNick = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputBrief = TextEditingController();
  TextEditingController inputPwd = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(userCreateProvider).removeImgMemory();
  }

  @override
  void dispose() {
    super.dispose();
    inputNick.dispose();
    inputPhone.dispose();
    inputEmail.dispose();
    inputBrief.dispose();
    inputPwd.dispose();
  }

  void onTapCreate() async {
    bool validate = formKey.currentState?.validate() ?? false;
    if (!validate) return;

    Toast.showLoading();
    await requestCreate();
    Toast.dismissLoading();
  }

  Future<void> requestCreate() async {
    var info = ref.read(userCreateProvider);

    if (info.avatar.imgData != null) {
      String objectName = Utils.objectName("avatar", info.avatar.imgData!.name);
      info.avatar.imgLink =
          await DioRequest().upload(info.avatar.imgData!.bytes, objectName);
      if (info.avatar.imgLink.isEmpty) return;
    }

    if (info.cover.imgData != null) {
      String objectName = Utils.objectName("cover", info.cover.imgData!.name);
      info.cover.imgLink =
          await DioRequest().upload(info.cover.imgData!.bytes, objectName);
      if (info.cover.imgLink.isEmpty) return;
    }

    await DioRequest()
        .request(HttpConstant.createAccount, method: DioMethod.POST, data: {
      "nickname": inputNick.text,
      "gender": info.gender,
      "areaCode": info.phoneArea,
      "birthday": info.birth,
      "phone": "${info.phoneArea}${inputPhone.text}",
      "email": inputEmail.text,
      "password": AppConstants.encryptPassword(inputPwd.text),
      "brief": inputBrief.text,
      "avatar": info.avatar.imgLink,
      "bgImg": info.cover.imgLink,
    });

    Toast.showToast("创建成功", true);
  }

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

  void onPickCover() async {
    List<XMLImage> files = await Utils.pickFile();
    if (files.isEmpty) return;

    var crop = await Utils.onCropImage(files.first);
    if (crop == null) return;

    files.first.bytes = crop;
    ref
        .read(userCreateProvider.notifier)
        .updateCover(BeanImage("", files.first));
  }

  void onState1Changed(String? string) {
    if (string == null) return;
    int index = stateList1.indexOf(string);
    if (index == -1) return;

    ref.read(userCreateProvider).gender = index;
  }

  void onBirthChanged(String date) {
    ref.read(userCreateProvider.notifier).updateBirth(date.substring(0, 10));
  }

  void onCodeChanged(String code) {
    ref.read(userCreateProvider).phoneArea = code;
  }

  Widget buildCreateContent() {
    var create = ref.watch(userCreateProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          UserTxtTitle("用户头像："),
          const SizedBox(height: 10, width: double.infinity),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: UserImage(image: create.avatar, onPick: onPickAvatar),
          ),
          const SizedBox(height: 20),
          UserTxtTitle("用户昵称：", require: true),
          const SizedBox(height: 10),
          UserEditInput.nick(inputNick, true),
          const SizedBox(height: 20),
          UserTxtTitle("性别："),
          const SizedBox(height: 10),
          UserEditDrop(
            stateList1[0],
            (_, __) async => stateList1,
            onChanged: onState1Changed,
            enable: true,
          ),
          const SizedBox(height: 20),
          UserTxtTitle("出生日期："),
          const SizedBox(height: 10),
          UserEditDate(create.birthday, true, onChanged: onBirthChanged),
          const SizedBox(height: 20),
          UserTxtTitle("手机：", require: true),
          const SizedBox(height: 10),
          UserEditInput.phone(
            inputPhone,
            true,
            PhonePrefix(create.phoneArea, true, onChanged: onCodeChanged),
          ),
          const SizedBox(height: 20),
          UserTxtTitle("邮箱地址："),
          const SizedBox(height: 10),
          UserEditInput.email(inputEmail, true),
          const SizedBox(height: 20),
          UserTxtTitle("密码：(6-18位的数字或字母,区分大小写)", require: true),
          const SizedBox(height: 10),
          UserEditInput.password(inputPwd, true),
          const SizedBox(height: 20),
          UserTxtTitle("用户简介："),
          const SizedBox(height: 10),
          UserEditInput.brief(inputBrief, true),
          const SizedBox(height: 20),
          UserTxtTitle("主页封面："),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: UserImage(image: create.cover, onPick: onPickCover),
          ),
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
