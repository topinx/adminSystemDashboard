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
      AccountInfoText("用户昵称", ctr.info.nickname),
      AccountInfoText("账号ID", "${ctr.info.userId}"),
      AccountInfoText("性别", ["未设置", "男", "女"][ctr.info.gender]),
      AccountInfoText("年龄", ctr.getUserAge()),
      AccountInfoText("出生日期", ctr.info.birthday),
      AccountInfoText("注册日期", ctr.getUserCreate()),
      AccountInfoText("绑定手机", ctr.info.phone),
      AccountInfoText("邮箱", ctr.info.email),
      AccountInfoText("地区", ctr.getUserArea()),
      AccountInfoText("用户简介", ctr.info.brief),
      AccountInfoImage("背景图", ctr.info.bgImg),
    ];
  }

  List<Widget> buildInfoInteractive() {
    String status1 =
        ["", "普通用户", "认证博主", "认证商户"][ctr.info.authenticationStatus];
    String status2 = ["已停用", "正常使用"][ctr.info.status];

    return [
      const Text(
        "互动信息",
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
      ),
      AccountInfoText("粉丝数", "${ctr.cnt.fansCnt}"),
      AccountInfoText("获赞数", "${ctr.cnt.beLikedCnt}"),
      AccountInfoText("关注数", "${ctr.cnt.followingCnt}"),
      AccountInfoText("互关数", "${ctr.cnt.friendCnt}"),
      AccountInfoText("账号状态", status1),
      AccountInfoText("认证状态", status2),
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

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        const AccountInfoBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: GetBuilder<AccountInfoController>(builder: (ctr) {
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
                    return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
            }),
          ),
        )
      ]),
    );
  }
}
