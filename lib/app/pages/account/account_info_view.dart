import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/responsive_widget.dart';
import 'package:top_back/app/widgets/view_container.dart';

import 'controller/account_info_controller.dart';
import 'widget/account_info_bar.dart';
import 'widget/account_info_birth.dart';
import 'widget/account_info_image.dart';
import 'widget/account_info_note.dart';
import 'widget/account_info_phone.dart';
import 'widget/account_info_text.dart';

class AccountInfoView extends StatefulWidget {
  const AccountInfoView({super.key});

  @override
  State<AccountInfoView> createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
  final AccountInfoController ctr = Get.find<AccountInfoController>();

  List<Widget> buildInfoBase() {
    return [
      const Text(
        "基本信息",
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
      ),
      AccountInfoImage(
        1,
        ctr.info.avatar,
        onChange: ctr.onAvatarChange,
        enable: ctr.isEditView,
      ),
      AccountInfoText("用户昵称", ctr.inputNick, enable: ctr.isEditView),
      AccountInfoText("账号ID", ctr.inputId),
      AccountInfoDrop(
        "性别",
        ctr.info.gender,
        const ["未设置", "男", "女"],
        enable: ctr.isEditView,
        onChange: ctr.onGenderChange,
      ),
      AccountInfoText("年龄", ctr.inputAge),
      AccountInfoBirth(
        ctr.info.birthday,
        enable: ctr.isEditView,
        onChange: ctr.onBirthChange,
      ),
      AccountInfoText("注册日期", ctr.inputCreate),
      AccountInfoPhone(
        ctr: ctr.inputPhone,
        enable: ctr.isEditView,
        onChange: ctr.onCodeChange,
        areaCode: ctr.info.areaCode,
      ),
      AccountInfoText("邮箱", ctr.inputEmail, enable: ctr.isEditView),
      // AccountInfoText("地区", ctr.getUserArea()),
      AccountInfoText("用户简介", ctr.inputBrief, enable: ctr.isEditView),
      AccountInfoImage(
        2,
        ctr.info.bgImg,
        onChange: ctr.onCoverChange,
        enable: ctr.isEditView,
      ),
    ];
  }

  List<Widget> buildInfoInteractive() {
    return [
      const Text(
        "互动信息",
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
      ),
      AccountInfoText("粉丝数", ctr.inputFans),
      AccountInfoText("获赞数", ctr.inputLike),
      AccountInfoText("关注数", ctr.inputFollow),
      AccountInfoText("互关数", ctr.inputFriend),
      AccountInfoDrop(
        "账号状态",
        ctr.info.authenticationStatus - 1,
        const ["普通用户", "认证博主", "认证商户"],
        enable: ctr.isEditView,
        onChange: ctr.onStatusAChange,
      ),
      AccountInfoDrop(
        "认证状态",
        ctr.info.status,
        const ["已停用", "正常使用"],
        enable: ctr.isEditView,
        onChange: ctr.onStatusVChange,
      ),
      const SizedBox(height: 20),
      Row(children: [
        const Text(
          "个人作品(0)",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        const Spacer(),
        TextButton(onPressed: ctr.onTapNote, child: const Text("查看全部")),
      ]),
      const AccountInfoNote(),
    ];
  }

  Widget buildInfoViewContent() {
    return GetBuilder<AccountInfoController>(builder: (ctr) {
      return ResponsiveWidget(builder: (type, constraints) {
        switch (type) {
          case ResponsiveType.mobile:
          case ResponsiveType.table:
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...buildInfoBase(),
                  const SizedBox(height: 20),
                  ...buildInfoInteractive(),
                ]);
          case ResponsiveType.desktop:
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: buildInfoBase()),
              ),
              Container(
                color: Colors.black12,
                margin: const EdgeInsets.fromLTRB(10, 0, 30, 0),
                width: 1,
                height: 800,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: buildInfoInteractive()),
              ),
            ]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        const AccountInfoBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: buildInfoViewContent(),
          ),
        )
      ]),
    );
  }
}
