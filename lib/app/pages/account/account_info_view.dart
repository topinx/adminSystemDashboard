import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/responsive_widget.dart';
import 'package:top_back/app/widgets/view_container.dart';

import 'controller/account_info_controller.dart';
import 'widget/account_info_bar.dart';
import 'widget/account_info_image.dart';
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
      AccountInfoImage("用户头像", ctr.info.avatar),
      AccountInfoText("用户昵称", ctr.inputNick),
      AccountInfoText("账号ID", ctr.inputId),
      AccountInfoDrop("性别", ctr.info.gender, const ["未设置", "男", "女"]),
      AccountInfoText("年龄", ctr.inputAge),
      // AccountInfoText("出生日期", ctr.info.birthday),
      AccountInfoText("注册日期", ctr.inputCreate),
      AccountInfoText("绑定手机", ctr.inputPhone),
      AccountInfoText("邮箱", ctr.inputEmail),
      // AccountInfoText("地区", ctr.getUserArea()),
      AccountInfoText("用户简介", ctr.inputBrief),
      AccountInfoImage("背景图", ctr.info.bgImg),
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
      AccountInfoDrop("账号状态", ctr.info.authenticationStatus,
          const ["", "普通用户", "认证博主", "认证商户"]),
      AccountInfoDrop("认证状态", ctr.info.status, const ["已停用", "正常使用"]),
      const SizedBox(height: 20),
      Row(children: [
        const Text(
          "个人作品(0)",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        const Spacer(),
        TextButton(onPressed: () {}, child: const Text("查看全部")),
      ]),
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
