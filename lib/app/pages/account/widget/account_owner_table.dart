import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/table_title_text.dart';
import 'package:top_back/bean/bean_account_list.dart';

import '../controller/account_controller.dart';

class AccountOwnerTable extends StatelessWidget {
  const AccountOwnerTable({super.key});

  TableRow buildTableTitle(AccountController ctr, int count) {
    bool select = ctr.selectList.isNotEmpty;
    bool selectAll = ctr.selectList.length == count && count > 0;

    return TableRow(
      decoration: const BoxDecoration(color: Colors.black12),
      children: [
        TableCell(
          child: TableSelect(ctr.onTapSelectAll, select, selectAll),
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

  TableRow buildTableRow(AccountController ctr, BeanAccountList bean) {
    String status1 = ["", "普通用户", "认证博主", "认证商户"][bean.authenticationStatus];
    String status2 = ["已停用", "正常使用"][bean.status];

    bool contain = ctr.selectList.contains(bean);

    return TableRow(
      children: [
        TableCell(
            child: TableSelect(() => ctr.onTapSelect(bean), false, contain)),
        TableCell(child: TableText(bean.nickname, false)),
        TableCell(child: TableText(bean.phone, false)),
        TableCell(child: TableText(bean.email, false)),
        TableCell(child: TableText(status1, false)),
        TableCell(child: TableText(status2, false)),
        TableCell(child: TableCheck(() => ctr.onTapCheck(bean))),
      ],
    );
  }

  Widget title(String string) {
    return Container(
      height: 50,
      width: 200,
      alignment: Alignment.center,
      child: Text(string),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: GetBuilder<AccountController>(
          id: "check-table",
          builder: (ctr) {
            int start = (ctr.pageNum - 1) * ctr.pageSize;
            int end = start + ctr.pageSize;
            end = end > ctr.beanList.length ? ctr.beanList.length : end;

            List<BeanAccountList> tempList = ctr.beanList.sublist(start, end);
            return Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
                4: FlexColumnWidth(),
                5: FlexColumnWidth(),
                6: FlexColumnWidth(),
              },
              children: [
                buildTableTitle(ctr, tempList.length),
                ...List.generate(
                    tempList.length, (i) => buildTableRow(ctr, tempList[i]))
              ],
            );
          }),
    );
  }
}
