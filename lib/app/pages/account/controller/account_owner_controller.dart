import 'package:bot_toast/bot_toast.dart';
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

  int accountCnt = 0;
  int checkCnt = 0;

  /// 账号状态 0 全部 1 正常使用 2 已停用
  int statusAccount = 0;

  /// 认证状态 0 全部 1 普通用户 2 认证博主 3 认证商户
  int statusVerify = 0;

  int pageNum = 1;

  int pageSize = 10;

  String checkNick = "";
  String checkPhone = "";
  String checkEmail = "";
  int? checkStatusA; // 1 正常 0 停用
  int? checkStatusV; // 1 普通 2 博主 3 商户

  List<BeanAccountList> beanList = [];

  List<BeanAccountList> selectList = [];

  @override
  void onReady() {
    super.onReady();
    requestCheckCount(all: true);
  }

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
    if (pageNum * pageSize <= beanList.length) {
      update(["check-table"]);
    } else {
      requestAccountList();
    }
  }

  void onTapSelect(BeanAccountList bean) {
    if (selectList.contains(bean)) {
      selectList.remove(bean);
    } else {
      selectList.add(bean);
    }
    update(["check-table"]);
  }

  void onTapSelectAll() {
    int start = (pageNum - 1) * pageSize;
    int end = start + pageSize;
    end = end > beanList.length ? beanList.length : end;

    if (selectList.length < end - start) {
      selectList = beanList.sublist(start, end);
    } else {
      selectList.clear();
    }
    update(["check-table"]);
  }

  void onTapCheck(BeanAccountList bean) {
    AppDelegate.delegate.toNamed(Routes.ACCOUNT_INFO("${bean.userId}"));
  }

  void onMultiOperate(int value) {
    if (selectList.isEmpty) {
      showToast("请先选择用户");
      return;
    }

    if (value == 0) {
      // 批量启用
      requestModify(1);
    } else {
      // 批量停用
      requestModify(0);
    }
  }

  void requestCheckCount({bool all = false}) async {
    int user = AppStorage().beanLogin.userId;
    await get(
      HttpConstants.accountCnt,
      param: all
          ? {"userId": user}
          : {
              "userId": user,
              "nickname": checkNick,
              "phone": checkPhone,
              "email": checkEmail,
              "status": checkStatusA,
              "authenticationStatus": checkStatusV,
            },
      success: (data) => all ? accountCnt = data : checkCnt = data,
    );

    update([all ? "user-count" : "check-page"]);
  }

  Future<void> requestAccountList() async {
    BotToast.showLoading();
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
    BotToast.closeAllLoading();
  }

  void onAccountList(data) {
    pageNum = data["pageNo"];
    if (pageNum == 1) {
      beanList.clear();
    }
    List tempList = data["list"] ?? [];
    beanList.addAll(tempList.map((x) => BeanAccountList.fromJson(x)).toList());
    update(["check-table"]);
  }

  Future<void> requestModify(int status) async {
    BotToast.showLoading();
    List users = selectList.map((x) => x.userId).toList();

    await post(
      HttpConstants.modifyStatus,
      param: {
        "userIdList": users,
        "status": status,
      },
      success: (data) {
        for (var user in users) {
          var bean1 = selectList.firstWhereOrNull((x) => x.userId == user);
          if (bean1 != null) {
            bean1.status = status;
          }
          var bean2 = beanList.firstWhereOrNull((x) => x.userId == user);
          if (bean2 != null) {
            bean2.status = status;
          }
        }
        update(["check-table"]);
      },
    );
    BotToast.closeAllLoading();
  }
}
