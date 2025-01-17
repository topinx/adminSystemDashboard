import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/table_list.dart';
import 'package:top_back/bean/bean_account_list.dart';

import '../controller/account_manage_controller.dart';

class AccountManageTable extends StatelessWidget {
  const AccountManageTable({super.key});

  Widget tableListBuilder(
      AccountManageController ctr, BeanAccountList bean, int index) {
    String status1 = ["", "普通用户", "认证博主", "认证商户"][bean.authenticationStatus];
    String status2 = ["已停用", "正常使用"][bean.status];

    return [
      TableListText(bean.nickname),
      TableListText(bean.phone),
      TableListText(bean.email),
      TableListText(status1),
      TableListText(status2),
      TableListCheck(onTap: () => ctr.onTapCheck(bean)),
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountManageController>(
      id: "check-table",
      builder: (ctr) {
        int start = (ctr.pageNum - 1) * ctr.pageSize;
        int end = start + ctr.pageSize;
        end = end > ctr.beanList.length ? ctr.beanList.length : end;

        List<BeanAccountList> tempList = ctr.beanList.sublist(start, end);

        return TableList(
          titleList: const ["账号名称", "手机号", "邮箱", "认证状态", "状态", "操作"],
          itemCount: tempList.length,
          onSelect: (selectList) {
            List<BeanAccountList> select =
                selectList.map((i) => tempList[i]).toList();
            ctr.onSelectChanged(select);
          },
          builder: (i, index) => tableListBuilder(ctr, tempList[i], index),
        );
      },
    );
  }
}
