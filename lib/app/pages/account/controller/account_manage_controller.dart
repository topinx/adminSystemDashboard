import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountManageController extends GetxController {
  TextEditingController inputNick = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputBrief = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  int gender = -1;

  DateTime? birthday;

  Uint8List? userAvatar;

  Uint8List? userCover;

  ImagePicker imagePicker = ImagePicker();

  @override
  void onClose() {
    super.onClose();
    inputNick.dispose();
    inputPhone.dispose();
    inputEmail.dispose();
    inputPassword.dispose();
    inputBrief.dispose();
  }

  String? validatorNick(String? string) {
    if (string == null || string.isEmpty) {
      return "请输入用户昵称";
    }

    return null;
  }

  String? validatorPhone(String? string) {
    if (string == null || string.isEmpty) {
      return "请输入手机号";
    }
    if (!string.isPhoneNumber) {
      return "请输入正确的手机号";
    }

    return null;
  }

  String? validatorEmail(String? string) {
    if (string != null && string.isNotEmpty && !string.isEmail) {
      return "请输入正确的邮箱地址";
    }

    return null;
  }

  String? validatorPassword(String? string) {
    if (string == null || string.isEmpty) {
      return "请输入密码";
    }
    bool hasMatch = RegExp(r'[0-9a-zA-Z]').hasMatch(string);
    if (string.length < 6 || string.length > 16 || !hasMatch) {
      return "请输入长度为6-16个字母或数字的密码";
    }

    return null;
  }

  void onGenderChanged(int value) => gender = value;

  void onTapAvatar() async {
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 300, maxHeight: 300);
    if (file == null) return;
    userAvatar = await file.readAsBytes();
    update();
  }

  void onTapCover() async {
    XFile? file = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      maxHeight: 800,
      imageQuality: 80,
    );
    if (file == null) return;
    userCover = await file.readAsBytes();
    update();
  }

  void onTapBirth(BuildContext context) async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: birthday,
      firstDate: DateTime(1790, 1, 1),
      lastDate: DateTime.now(),
    );
    if (dateTime == null) return;
    birthday = dateTime;
    update();
  }

  void onTapConfirm() {
    if (formKey.currentState?.validate() == false) return;
  }
}
