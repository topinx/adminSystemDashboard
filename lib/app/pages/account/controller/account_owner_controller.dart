import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/app_delegate.dart';
import 'package:top_back/app/pages.dart';
import 'package:top_back/bean/bean_account_list.dart';
import 'package:top_back/contants/app_storage.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class AccountOwnerController extends GetxController with RequestMixin {
  TextEditingController inputName = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputEmail = TextEditingController();

  /// 账号状态 0 全部 1 正常使用 2 已停用
  int statusAccount = 0;

  /// 认证状态 0 全部 1 普通用户 2 认证博主 3 认证商户
  int statusVerify = 0;

  /// 用户数量
  int accountCnt = 0;

  int pageNum = 1;

  int pageSize = 10;

  String checkNick = "";
  String checkPhone = "";
  String checkEmail = "";
  int? checkStatusA; // 1 正常 0 停用
  int? checkStatusV; // 1 普通 2 博主 3 商户

  Map<int, List<BeanAccountList>> beanList = {};
  int checkAccountCount = 0;

  Map<int, List<BeanAccountList>> selectList = {};

  @override
  void onClose() {
    super.onClose();
    inputName.dispose();
    inputPhone.dispose();
    inputEmail.dispose();
  }

  void onTapSearch() {
    checkNick = inputName.text;
    checkPhone = inputPhone.text;
    checkEmail = inputEmail.text;
    checkStatusA = getCheckStatusA();
    checkStatusV = getCheckStatusV();

    pageNum = 1;
    requestCheckCount();
    requestAccountList();
  }

  void onTapReset() {
    inputName.clear();
    inputPhone.clear();
    inputEmail.clear();

    statusVerify = 0;
    statusAccount = 0;
    update(["check-status"]);

    checkNick = "";
    checkPhone = "";
    checkEmail = "";

    checkStatusA = null;
    checkStatusV = null;
  }

  int? getCheckStatusA() {
    if (statusAccount == 1) return 1;
    if (statusAccount == 2) return 0;
    return null;
  }

  int? getCheckStatusV() {
    if (statusVerify > 0) return statusVerify;
    return null;
  }

  void onTapCreate() {
    AppDelegate.delegate.offNamed(Routes.accountManage);
  }

  void onStatusAChanged(int status) {
    statusAccount = status;
  }

  void onStatusVChanged(int status) {
    statusVerify = status;
  }

  void onTapPage(int page) {
    pageNum = page;
    if ((pageNum - 1) * pageSize <= beanList.length) {
      update(["check-table"]);
    } else {
      requestAccountList();
    }
  }

  void onPageSizeChanged(int size) {
    pageSize = size;
    pageNum = 1;
    if ((pageNum - 1) * pageSize <= beanList.length) {
      update(["check-table"]);
    } else {
      requestAccountList();
    }
  }

  void onTapSelect(BeanAccountList bean) {
    if (!selectList.containsKey(pageNum)) {
      selectList[pageNum] = [];
    }
    if (selectList[pageNum]!.contains(bean)) {
      selectList[pageNum]!.remove(bean);
    } else {
      selectList[pageNum]!.add(bean);
    }
    update(["check-table"]);
  }

  void onTapSelectAll() {
    List tempList = selectList[pageNum] ?? [];
    if (tempList.length == beanList[pageNum]?.length) {
      selectList.remove(pageNum);
    } else {
      selectList[pageNum] = beanList[pageNum] ?? [];
    }
    update(["check-table"]);
  }

  void onTapCheck(BeanAccountList bean) {}

  void onMultiOperate(int value) {
    if (value == 0) {
      // 批量启用
    } else {
      // 批量停用
    }
  }

  void requestCheckCount() async {
    checkAccountCount = 14;
    await Future.delayed(const Duration(seconds: 1));
    update(["check-page"]);
  }

  Future<void> requestAccountList() async {
    int user = AppStorage().beanLogin.userId;
    await get(
      HttpConstants.accountList,
      param: {
        "pageNo": pageNum,
        "limit": pageSize,
        "userId": user,
        "nickname": checkNick,
        "phone": checkPhone,
        "email": checkEmail,
        "status": checkStatusA,
        "authenticationStatus": checkStatusV,
      },
      success: onAccountList,
    );
  }

  void onAccountList(data) {
    pageNum = data["pageNo"];
    List tempList = data["list"] ?? [];
    beanList[pageNum] =
        tempList.map((x) => BeanAccountList.fromJson(x)).toList();
    update(["check-table"]);
  }
}
