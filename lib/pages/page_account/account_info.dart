import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:top_back/bean/bean_account_info.dart';
import 'package:top_back/bean/bean_image.dart';
import 'package:top_back/bean/bean_inter_cnt.dart';
import 'package:top_back/bean/bean_note.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/pages/page_account/provider/account_info_provider.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/pages/widget/image.dart';
import 'package:top_back/pages/widget/page_card.dart';
import 'package:top_back/router/router.dart';
import 'package:top_back/toast/toast.dart';
import 'package:top_back/util/utils.dart';
import 'package:dio/dio.dart' as dio;

import 'widget/user_edit_drop.dart';
import 'widget/user_edit_input.dart';
import 'widget/user_note_card.dart';
import 'widget/user_txt_title.dart';

class AccountInfo extends ConsumerStatefulWidget {
  const AccountInfo(this.user, {super.key});

  final String user;

  @override
  ConsumerState<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends ConsumerState<AccountInfo> {
  GlobalKey<FormState> formKey = GlobalKey();

  final stateList1 = ["未设置", "男", "女"];
  final stateList2 = ["已停用", "正常使用"];
  final stateList3 = ["普通用户", "认证博主", "认证商户"];

  TextEditingController inputNick = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputBrief = TextEditingController();

  BeanAccountInfo account = BeanAccountInfo();

  @override
  void initState() {
    super.initState();
    ref.read(userInfoProvider).removeImgMemory();
    requestUserInfo();
    requestInterCnt();
    requestNoteInfo();
  }

  @override
  void dispose() {
    super.dispose();
    inputNick.dispose();
    inputPhone.dispose();
    inputEmail.dispose();
    inputBrief.dispose();
  }

  Future<void> requestUserInfo() async {
    var response = await DioRequest().request(
      HttpConstant.accountInfo,
      query: {"userId": widget.user},
    );
    if (response is bool && !response) return;

    account = BeanAccountInfo.fromJson(response);
    onUserInfo();
  }

  void onUserInfo() {
    inputNick.text = account.nickname;
    inputPhone.text = account.phone.replaceFirst(account.areaCode, "");
    inputEmail.text = account.email;
    inputBrief.text = account.brief;

    ref.read(userInfoProvider.notifier).updateWithUserInfo(account);
  }

  Future<void> requestInterCnt() async {
    var response = await DioRequest().request(
      HttpConstant.interactiveCnt,
      query: {"userId": widget.user},
    );
    ref.read(userInterProvider.notifier).state =
        BeanInterCnt.fromJson(response);
  }

  Future<void> requestReset() async {
    var response = await DioRequest().request(
      HttpConstant.resetAccount,
      method: DioMethod.POST,
      data:
          dio.FormData.fromMap({"userId": widget.user, "phone": account.phone}),
    );
    if (response is bool && !response) return;

    account = BeanAccountInfo.fromJson(response);
    onUserInfo();
  }

  Future<void> requestResetPwd() async {
    var response = await DioRequest().request(
      HttpConstant.resetPassword,
      method: DioMethod.POST,
      data: dio.FormData.fromMap({"userId": widget.user}),
    );
    if (response is bool && !response) return;

    Toast.showToast("重置成功", true);
  }

  Future<void> requestEdit() async {
    var info = ref.read(userInfoProvider);

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
        .request(HttpConstant.editAccount, method: DioMethod.POST, data: {
      "userId": widget.user,
      "phone": info.phoneArea + inputPhone.text,
      "areaCode": info.phoneArea,
      "nickname": inputNick.text,
      "brief": inputBrief.text,
      "gender": info.gender,
      "birthday": info.birth,
      "bgImg": info.cover.imgLink,
      "email": inputEmail.text,
      "avatar": info.avatar.imgLink,
      "area": account.area,
      "status": info.state_a,
      "authenticationStatus": info.state_v,
    });

    onEditSuccess();
  }

  void onEditSuccess() {
    Toast.showToast("修改成功", true);

    var info = ref.read(userInfoProvider);
    account.phone = info.phoneArea + inputPhone.text;
    account.areaCode = info.phoneArea;
    account.nickname = inputNick.text;
    account.brief = inputBrief.text;
    account.gender = info.gender;
    account.birthday = info.birth;
    account.bgImg = info.cover.imgLink;
    account.email = inputEmail.text;
    account.avatar = info.avatar.imgLink;
    account.status = info.state_a;
    account.authenticationStatus = info.state_v;
    onUserInfo();
  }

  Future<void> requestNoteInfo() async {
    var value = await Future.wait([requestNoteCnt(), requestNoteList()]);
    if (value.isEmpty) return;
    int count = value[0] as int;
    BeanNote note = value[1] as BeanNote;
    ref.read(userNoteProvider.notifier).state = UserNoteInfo()
      ..count = count
      ..note = note;
  }

  Future<int> requestNoteCnt() async {
    return await DioRequest().request(HttpConstant.noteCnt, query: {
      "createByList": [widget.user]
    });
  }

  Future<BeanNote> requestNoteList() async {
    var response = await DioRequest().request(HttpConstant.noteList, query: {
      "pageNo": 1,
      "limit": 1,
      "createByList": [widget.user],
    });

    List<dynamic> data = response?["list"] ?? [];
    if (data.isEmpty) return BeanNote();

    return BeanNote.fromJson(data.first);
  }

  void onTapEdit() {
    ref.read(userEditProvider.notifier).state = true;
  }

  void onTapCancel() {
    inputNick.text = account.nickname;
    inputPhone.text = account.phone.replaceFirst(account.areaCode, "");
    inputEmail.text = account.email;
    inputBrief.text = account.brief;

    formKey.currentState?.reset();
    ref.read(userInfoProvider.notifier).updateWithUserInfo(account);
    ref.read(userEditProvider.notifier).state = false;
  }

  void onTapSave() async {
    bool validate = formKey.currentState?.validate() ?? false;
    if (!validate) return;

    Toast.showLoading();
    await requestEdit();
    Toast.dismissLoading();
  }

  void onTapResetPwd() async {
    bool? confirm = await Toast.showAlert("确定重置密码？");
    if (confirm == null || !confirm) return;

    Toast.showLoading();
    await requestResetPwd();
    Toast.dismissLoading();
  }

  void onTapReset() async {
    bool? confirm = await Toast.showAlert("确定重置信息？");
    if (confirm == null || !confirm) return;

    Toast.showLoading();
    await requestReset();
    Toast.dismissLoading();
  }

  void onTapCheck() {
    context.push(RouterPath.account_note(int.parse(widget.user)));
  }

  void onPickAvatar() async {
    if (!ref.read(userEditProvider)) return;
    List<XMLImage> files = await Utils.pickFile();
    if (files.isEmpty) return;

    var crop = await Utils.onCropImage(files.first);
    if (crop == null) return;

    files.first.bytes = crop;
    ref
        .read(userInfoProvider.notifier)
        .updateAvatar(BeanImage(account.avatar, files.first));
  }

  void onPickCover() async {
    if (!ref.read(userEditProvider)) return;
    List<XMLImage> files = await Utils.pickFile();
    if (files.isEmpty) return;

    var crop = await Utils.onCropImage(files.first);
    if (crop == null) return;
    files.first.bytes = crop;
    ref
        .read(userInfoProvider.notifier)
        .updateCover(BeanImage(account.bgImg, files.first));
  }

  void onState1Changed(String? string) {
    if (string == null) return;
    int index = stateList1.indexOf(string);
    if (index == -1) return;

    ref.read(userInfoProvider).gender = index;
  }

  void onState2Changed(String? string) {
    if (string == null) return;
    int index = stateList2.indexOf(string);
    if (index == -1) return;
    ref.read(userInfoProvider).state_a = index;
  }

  void onState3Changed(String? string) {
    if (string == null) return;
    int index = stateList3.indexOf(string);
    if (index == -1) return;
    ref.read(userInfoProvider).state_v = index + 1;
  }

  void onBirthChanged(String date) {
    ref.read(userInfoProvider.notifier).updateBirth(date.substring(0, 10));
  }

  void onCodeChanged(String code) {
    ref.read(userInfoProvider).phoneArea = code;
  }

  Widget buildAppBar() {
    var edit = ref.watch(userEditProvider);

    return Row(children: [
      PopButton(),
      const Spacer(),
      if (edit) ...[
        ElvButton("重置信息", warn: true, onTap: onTapReset),
        const SizedBox(width: 5),
        ElvButton("重置密码", warn: true, onTap: onTapResetPwd),
        const SizedBox(width: 5),
        ElvButton("保存", onTap: onTapSave),
        const SizedBox(width: 5),
        ElvButton("取消", onTap: onTapCancel),
      ] else ...[
        ElvButton("编辑", onTap: onTapEdit),
      ]
    ]);
  }

  Widget buildUserInfo1() {
    var info = ref.watch(userInfoProvider);
    var edit = ref.watch(userEditProvider);

    return Form(
      key: formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("基本信息",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        const SizedBox(height: 20, width: double.infinity),
        UserTxtTitle("用户头像："),
        const SizedBox(height: 10),
        PickImage(image: info.avatar, onPick: onPickAvatar),
        const SizedBox(height: 20),
        UserTxtTitle("用户昵称："),
        const SizedBox(height: 10),
        UserEditInput.nick(inputNick, edit),
        const SizedBox(height: 20),
        UserTxtTitle("账号ID："),
        const SizedBox(height: 10),
        UserEditText("${widget.user}"),
        const SizedBox(height: 20),
        UserTxtTitle("性别："),
        const SizedBox(height: 10),
        UserEditDrop(
          stateList1[info.gender],
          (_, __) async => stateList1,
          onChanged: onState1Changed,
          enable: edit,
        ),
        const SizedBox(height: 20),
        UserTxtTitle("年龄："),
        const SizedBox(height: 10),
        UserEditText("${info.age}"),
        const SizedBox(height: 20),
        UserTxtTitle("出生日期："),
        const SizedBox(height: 10),
        UserEditDate(info.birthday, edit, onChanged: onBirthChanged),
        const SizedBox(height: 20),
        UserTxtTitle("注册日期："),
        const SizedBox(height: 10),
        UserEditText(info.createDate),
        const SizedBox(height: 20),
        UserTxtTitle("绑定手机："),
        const SizedBox(height: 10),
        UserEditInput.phone(
          inputPhone,
          edit,
          PhonePrefix(info.phoneArea, edit, onChanged: onCodeChanged),
        ),
        const SizedBox(height: 20),
        UserTxtTitle("邮箱地址："),
        const SizedBox(height: 10),
        UserEditInput.email(inputEmail, edit),
      ]),
    );
  }

  Widget buildUserInfo2() {
    var info = ref.watch(userInfoProvider);
    var edit = ref.watch(userEditProvider);
    var count = ref.watch(userInterProvider);
    var note = ref.watch(userNoteProvider);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      UserTxtTitle("用户简介："),
      const SizedBox(height: 10),
      UserEditInput.brief(inputBrief, edit),
      const SizedBox(height: 20),
      UserTxtTitle("主页封面："),
      const SizedBox(height: 10),
      PickImage(image: info.cover, onPick: onPickCover),
      const SizedBox(height: 20),
      UserTxtTitle("账号状态："),
      const SizedBox(height: 10),
      UserEditDrop(
        stateList2[info.state_a],
        (_, __) async => stateList2,
        onChanged: onState2Changed,
        enable: edit,
      ),
      const SizedBox(height: 20),
      UserTxtTitle("认证状态："),
      const SizedBox(height: 10),
      UserEditDrop(
        stateList3[info.state_v - 1],
        (_, __) async => stateList3,
        onChanged: onState3Changed,
        enable: edit,
      ),
      const SizedBox(height: 20),
      Text("互动信息", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      const SizedBox(height: 20),
      Text("粉丝数：${count.fansCnt}"),
      const SizedBox(height: 10),
      Text("获赞数：${count.beLikedCnt}"),
      const SizedBox(height: 10),
      Text("关注数：${count.followingCnt}"),
      const SizedBox(height: 10),
      Text("互关数：${count.friendCnt}"),
      const SizedBox(height: 10),
      const SizedBox(height: 20),
      Row(children: [
        Text("个人作品(${note.count})",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        const SizedBox(width: 20),
        TxtButton("查看全部", onTap: onTapCheck),
      ]),
      const SizedBox(height: 20),
      UserNoteCard(note.note),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return PageCard(
      view: Column(children: [
        buildAppBar(),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Flexible(child: buildUserInfo1()),
              Flexible(child: buildUserInfo2()),
            ]),
          ),
        ),
      ]),
    );
  }
}
