import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/bean/bean_account_info.dart';
import 'package:top_back/bean/bean_inter_cnt.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class AccountInfoController extends GetxController with RequestMixin {
  String userId = "";

  BeanAccountInfo info = BeanAccountInfo.empty();
  BeanInterCnt cnt = BeanInterCnt.empty();

  TextEditingController inputNick = TextEditingController();
  TextEditingController inputId = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputBrief = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    userId = Get.parameters["userId"] ?? "";
  }

  @override
  void onReady() {
    super.onReady();
    // requestUserInfo();
    // requestInteractiveCnt();
  }

  @override
  void onClose() {
    super.onClose();
    inputNick.dispose();
    inputId.dispose();
    inputPhone.dispose();
    inputEmail.dispose();
    inputBrief.dispose();
  }

  String getUserAge() {
    if (info.birthday.isEmpty) return "";

    DateTime birthDate = DateTime.parse(info.birthday);
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
    update();
  }

  Future<void> requestInteractiveCnt() async {
    await get(HttpConstants.interactiveCnt,
        param: {"userId": userId}, success: onInteractiveCnt);
  }

  void onInteractiveCnt(data) {
    cnt = BeanInterCnt.fromJson(data);
    update();
  }
}
