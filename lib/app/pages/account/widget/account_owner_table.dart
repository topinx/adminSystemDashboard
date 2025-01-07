import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/table_title_text.dart';
import 'package:top_back/bean/bean_account_list.dart';

import '../controller/account_owner_controller.dart';

class AccountOwnerTable extends StatelessWidget {
  const AccountOwnerTable({super.key});

  TableRow buildTableTitle(AccountOwnerController ctr) {
    List tempList = ctr.selectList[ctr.pageNum] ?? [];
    bool selectAll = tempList.length == ctr.beanList[ctr.pageNum]?.length;

    return TableRow(
      decoration: const BoxDecoration(color: Colors.black12),
      children: [
        TableCell(
          child:
              TableSelect(ctr.onTapSelectAll, tempList.isNotEmpty, selectAll),
        ),
        const TableCell(child: TableText("账号名称", true)),
        const TableCell(child: TableText("手机号", true)),
        const TableCell(child: TableText("邮箱", true)),
        const TableCell(child: TableText("认证状态", true)),
        const TableCell(child: TableText("状态", true)),
        const TableCell(child: TableText("操作", true)),
      ],
    );
  }

  TableRow buildTableRow(AccountOwnerController ctr, BeanAccountList bean) {
    String statusV = ["", "普通用户", "认证博主", "认证商户"][bean.authenticationStatus];
    String statusA = ["已停用", "正常使用"][bean.authenticationStatus];

    bool contain = ctr.selectList[ctr.pageNum]?.contains(bean) == true;

    return TableRow(
      children: [
        TableCell(
            child: TableSelect(() => ctr.onTapSelect(bean), false, contain)),
        TableCell(child: TableText(bean.nickname, false)),
        TableCell(child: TableText(bean.phone, false)),
        TableCell(child: TableText(bean.email, false)),
        TableCell(child: TableText(statusV, false)),
        TableCell(child: TableText(statusA, false)),
        TableCell(child: TableCheckInfo(() => ctr.onTapCheck(bean))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: GetBuilder<AccountOwnerController>(
          id: "check-table",
          builder: (ctr) {
            List<BeanAccountList> tempList = ctr.beanList[ctr.pageNum] ?? [];
            return Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                1: MaxColumnWidth(
                    FixedColumnWidth(50.0), FractionColumnWidth(0.1)),
                2: MaxColumnWidth(
                    FixedColumnWidth(100.0), FractionColumnWidth(0.2)),
                3: MaxColumnWidth(
                    FixedColumnWidth(100.0), FractionColumnWidth(0.2)),
                4: MaxColumnWidth(
                    FixedColumnWidth(100.0), FractionColumnWidth(0.2)),
                5: MaxColumnWidth(
                    FixedColumnWidth(80.0), FractionColumnWidth(0.1)),
                6: MaxColumnWidth(
                    FixedColumnWidth(80.0), FractionColumnWidth(0.1)),
                7: MaxColumnWidth(
                    FixedColumnWidth(80.0), FractionColumnWidth(0.1)),
              },
              children: [
                buildTableTitle(ctr),
                ...List.generate(
                    tempList.length, (i) => buildTableRow(ctr, tempList[i]))
              ],
            );
          }),
    );
  }
}
