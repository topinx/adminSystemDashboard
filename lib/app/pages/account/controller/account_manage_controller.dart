import 'dart:typed_data';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_back/app/widgets/responsive_widget.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class AccountManageController extends GetxController with RequestMixin {
  TextEditingController inputNick = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputBrief = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  /// (1-男性 2-女性 3-其他 0-未设置)
  int gender = 0;

  DateTime? birth;

  String phoneCode = "1";

  XFile? userAvatarFile;
  Uint8List? userAvatar;
  XFile? userCoverFile;
  Uint8List? userCover;

  ImagePicker imagePicker = ImagePicker();

  bool isLoading = false;

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

  void onGenderChanged(int value) {
    if (value == 0) {
      gender = 1;
    } else if (value == 1) {
      gender = 2;
    }
  }

  void onTapAvatar() async {
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 300, maxHeight: 300);
    if (file == null) return;
    userAvatarFile = file;
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
    userCoverFile = file;
    userCover = await file.readAsBytes();
    update();
  }

  void onTapBirth(BuildContext context) async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: birth,
      firstDate: DateTime(1790, 1, 1),
      lastDate: DateTime.now(),
    );
    if (dateTime == null) return;
    birth = dateTime;
    update();
  }

  void onTapAreaCode(BuildContext context) async {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: const CountryListThemeData(
        bottomSheetWidth: kMobileToTable,
        bottomSheetHeight: 400,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      onSelect: (Country country) {
        phoneCode = country.phoneCode;
        update();
      },
    );
  }

  Future<String> getUserAvatar() async {
    if (userAvatar == null || userAvatarFile == null) return "";

    String name =
        "avatar/${DateTime.now().millisecondsSinceEpoch}/${userAvatarFile!.name}";
    return await upload(userAvatar!, name);
  }

  Future<String> getUserCover() async {
    if (userCover == null || userCoverFile == null) return "";

    String name =
        "cover/${DateTime.now().millisecondsSinceEpoch}/${userCoverFile!.name}";
    return await upload(userCover!, name);
  }

  void resetData() {
    inputNick.clear();
    inputPhone.clear();
    inputEmail.clear();
    inputPassword.clear();
    inputBrief.clear();

    gender = 0;
    birth = null;
    phoneCode = "1";

    userAvatarFile = null;
    userAvatar = null;
    userCoverFile = null;
    userCover = null;
  }

  void onTapConfirm() async {
    if (formKey.currentState?.validate() == false) return;
    if (isLoading) return;
    isLoading = true;
    update();

    String birthday =
        birth == null ? "" : "${birth!.year}-${birth!.month}-${birth!.day}";

    String avatarPath = await getUserAvatar();
    String coverPath = await getUserCover();

    String pwd = encryptPassword(inputPassword.text);

    await post(
      HttpConstants.createAccount,
      param: {
        "nickname": inputNick.text,
        "gender": gender,
        "areaCode": "+$phoneCode",
        "birthday": birthday,
        "phone": "+$phoneCode${inputPhone.text}",
        "email": inputEmail.text,
        "password": pwd,
        "brief": inputBrief.text,
        "avatar": avatarPath,
        "bgImg": coverPath,
      },
      success: (_) {
        resetData();
        showToast("创建成功");
      },
    );

    isLoading = false;
    update();
  }
}
