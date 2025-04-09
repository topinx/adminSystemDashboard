import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_back/app/widgets/responsive_widget.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class AccountCreateController extends GetxController with RequestMixin {
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

  String fileAvatarName = "";
  Uint8List? userAvatar;
  String fileCoverName = "";
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

  void onGenderChanged(int value) {
    if (value == 0) {
      gender = 1;
    } else if (value == 1) {
      gender = 2;
    }
  }

  void onTapAvatar() async {
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 80);
    if (file == null) return;
    fileAvatarName = file.name;
    userAvatar = await onCropImage(file);
    update();
  }

  void onTapCover() async {
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 80);
    if (file == null) return;
    fileCoverName = file.name;
    userCover = await onCropImage(file);
    update();
  }

  Future<Uint8List?> onCropImage(XFile file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 100,
      uiSettings: [WebUiSettings(context: Get.context!)],
    );
    return await croppedFile?.readAsBytes();
  }

  void onTapAreaCode(BuildContext context) async {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: const CountryListThemeData(
        bottomSheetWidth: kMobileToTable,
        bottomSheetHeight: 600,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      onSelect: (Country country) {
        phoneCode = country.phoneCode;
        update();
      },
    );
  }

  Future<String> getUserAvatar() async {
    if (userAvatar == null) return "";
    return await upload(userAvatar!, "avatar", fileAvatarName);
  }

  Future<String> getUserCover() async {
    if (userCover == null) return "";
    return await upload(userCover!, "cover", fileCoverName);
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

    fileAvatarName = "";
    userAvatar = null;
    fileCoverName = "";
    userCover = null;
  }

  void onTapConfirm() async {
    if (formKey.currentState?.validate() == false) return;
    BotToast.showLoading();

    String birthday = "";
    if (birth != null) {
      String year = "${birth!.year}".padLeft(4, "0");
      String month = "${birth!.month}".padLeft(2, "0");
      String day = "${birth!.day}".padLeft(2, "0");
      birthday = "$year-$month-$day";
    }

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

    BotToast.closeAllLoading();
    update();
  }
}
