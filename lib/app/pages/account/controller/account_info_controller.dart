import 'dart:convert';
import 'dart:typed_data';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart' as dio;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';
import 'package:top_back/bean/bean_account_info.dart';
import 'package:top_back/bean/bean_inter_cnt.dart';
import 'package:top_back/bean/bean_note_list.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class AccountInfoController extends GetxController with RequestMixin {
  int userId = 0;

  BeanAccountInfo info = BeanAccountInfo.empty();
  BeanInterCnt cnt = BeanInterCnt.empty();

  BeanAccountInfo edit = BeanAccountInfo.empty();

  bool isEditView = false;

  TextEditingController inputNick = TextEditingController();
  TextEditingController inputId = TextEditingController();
  TextEditingController inputAge = TextEditingController();
  TextEditingController inputCreate = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputBrief = TextEditingController();

  TextEditingController inputFans = TextEditingController();
  TextEditingController inputLike = TextEditingController();
  TextEditingController inputFollow = TextEditingController();
  TextEditingController inputFriend = TextEditingController();

  Uint8List? dataAvatar;
  String nameAvatar = "";

  Uint8List? dataCover;
  String nameCover = "";

  List<BeanNoteList> beanList = [];
  int checkCnt = 0;

  @override
  void onInit() {
    super.onInit();
    userId = int.parse(Get.parameters["userId"] ?? "0");
  }

  @override
  void onReady() {
    super.onReady();
    requestUserInfo();
    requestInteractiveCnt();
    requestNoteList();
    requestNoteCnt();
  }

  @override
  void onClose() {
    super.onClose();
    inputNick.dispose();
    inputId.dispose();
    inputAge.dispose();
    inputCreate.dispose();
    inputPhone.dispose();
    inputEmail.dispose();
    inputBrief.dispose();
    inputFans.dispose();
    inputLike.dispose();
    inputFollow.dispose();
    inputFriend.dispose();
  }

  void onTapEdit({bool? removeImg = true}) {
    isEditView = !isEditView;
    if (isEditView) {
      edit = BeanAccountInfo.fromJson(info.toJson());

      if (removeImg ?? true) {
        dataAvatar = null;
        dataCover = null;
      }
    } else {
      inputNick.text = info.nickname;
      inputId.text = "${info.userId}";
      inputAge.text = getUserAge(birthday: info.birthday);
      inputCreate.text = getUserCreate();
      inputPhone.text = info.phone.replaceFirst(info.areaCode, "");
      inputEmail.text = info.email;
      inputBrief.text = info.brief;
    }

    update();
  }

  void onTapNote() {
    Get.toNamed(Routes.ACCOUNT_NOTE(userId));
  }

  void onTapResetAccount() {
    requestResetAccount();
  }

  void onTapResetPassword() {
    requestResetPassword();
  }

  void onTapEditConfirm() async {
    BotToast.showLoading();

    BeanAccountInfo bean = BeanAccountInfo.fromJson(edit.toJson());
    bean.phone = bean.areaCode + inputPhone.text;
    bean.nickname = inputNick.text;
    bean.brief = inputBrief.text;
    bean.email = inputEmail.text;

    onTapEdit(removeImg: false);

    if (dataAvatar != null) {
      bean.avatar = await upload(dataAvatar!,"avatar", nameAvatar);
    }
    if (dataCover != null) {
      bean.bgImg = await upload(dataCover!,"cover" ,nameCover);
    }
    dataAvatar = null;
    dataCover = null;
    await requestEditAccount(bean);

    BotToast.closeAllLoading();
  }

  void onGenderChange(int value) {
    edit.gender = value;
  }

  void onStatusAChange(int value) {
    edit.authenticationStatus = value + 1;
  }

  void onStatusVChange(int value) {
    edit.status = value;
  }

  void onBirthChange(String value) {
    edit.birthday = value;
    inputAge.text = getUserAge(birthday: edit.birthday);
  }

  void onCodeChange(String code) {
    edit.areaCode = code;
    edit.phone = code + inputPhone.text;
  }

  void onAvatarChange(String name, Uint8List data) {
    nameAvatar = name;
    dataAvatar = data;
  }

  void onCoverChange(String name, Uint8List data) {
    nameCover = name;
    dataCover = data;
  }

  String getUserAge({String? birthday}) {
    birthday ??= info.birthday;
    if (birthday.isEmpty) return "";

    DateTime birthDate = DateTime.parse(birthday);
    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return "$age";
  }

  String getUserCreate() {
    return info.createTime == 0
        ? ""
        : DateTime.fromMillisecondsSinceEpoch(info.createTime)
            .toString()
            .substring(0, 19);
  }

  String getUserArea() {
    if (info.area.isEmpty) return "";

    var data = json.decode(info.area);
    String nameCn = data["nameCn"] ?? "";
    String nameEn = data["nameEn"] ?? "";
    return nameCn.isEmpty ? nameEn : nameCn;
  }

  Future<void> requestUserInfo() async {
    await get(HttpConstants.accountInfo,
        param: {"userId": userId}, success: onUserInfoSuccess);
  }

  void onUserInfoSuccess(data) {
    info = BeanAccountInfo.fromJson(data);
    edit = BeanAccountInfo.fromJson(data);

    inputNick.text = info.nickname;
    inputId.text = "${info.userId}";
    inputAge.text = getUserAge();
    inputCreate.text = getUserCreate();
    inputPhone.text = info.phone.replaceFirst(info.areaCode, "");
    inputEmail.text = info.email;
    inputBrief.text = info.brief;

    update();
  }

  Future<void> requestInteractiveCnt() async {
    await get(HttpConstants.interactiveCnt,
        param: {"userId": userId}, success: onInteractiveCnt);
  }

  void onInteractiveCnt(data) {
    cnt = BeanInterCnt.fromJson(data);

    inputFans.text = "${cnt.fansCnt}";
    inputLike.text = "${cnt.beLikedCnt}";
    inputFollow.text = "${cnt.followingCnt}";
    inputFriend.text = "${cnt.friendCnt}";
  }

  Future<void> requestEditAccount(BeanAccountInfo bean) async {
    await post(
      HttpConstants.editAccount,
      param: {
        "userId": bean.userId,
        "phone": bean.phone,
        "areaCode": bean.areaCode,
        "nickname": bean.nickname,
        "brief": bean.brief,
        "gender": bean.gender,
        "birthday": bean.birthday,
        "bgImg": bean.bgImg,
        "email": bean.email,
        "avatar": bean.avatar,
        "area": bean.area,
        "status": bean.status,
        "authenticationStatus": bean.authenticationStatus,
      },
      success: (data) {
        showToast("账号已修改");
        onUserInfoSuccess(data);
      },
    );
  }

  Future<void> requestResetAccount() async {
    onTapEdit();
    await post(
      HttpConstants.resetAccount,
      param: dio.FormData.fromMap({"userId": info.userId, "phone": info.phone}),
      success: (data) {
        showToast("账号已重置");
        onUserInfoSuccess(data);
      },
    );
  }

  Future<void> requestResetPassword() async {
    onTapEdit();
    await post(
      HttpConstants.resetPassword,
      param: dio.FormData.fromMap({"userId": info.userId}),
      success: (_) => showToast("密码已重置"),
    );
  }

  Future<void> requestNoteCnt() async {
    await get(
      HttpConstants.noteCnt,
      param: {
        "createByList": [userId]
      },
      success: (data) => checkCnt = data,
    );
    update(["note-count"]);
  }

  Future<void> requestNoteList() async {
    await get(
      HttpConstants.noteList,
      param: {
        "pageNo": 1,
        "limit": 2,
        "createByList": [userId],
      },
      success: onNoteList,
    );
    BotToast.closeAllLoading();
  }

  void onNoteList(data) {
    List tempList = data["list"] ?? [];
    beanList = tempList.map((x) => BeanNoteList.fromJson(x)).toList();
    update(["note-list"]);
  }
}
