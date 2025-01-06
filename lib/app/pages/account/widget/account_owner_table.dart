import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/table_title_text.dart';

import '../controller/account_owner_controller.dart';

class AccountOwnerTable extends StatelessWidget {
  const AccountOwnerTable({super.key});

  TableRow buildTableTitle(AccountOwnerController ctr) {
    return const TableRow(
      decoration: BoxDecoration(color: Colors.black12),
      children: [
        TableCell(child: TableSelect()),
        TableCell(child: TableText("账号名称", true)),
        TableCell(child: TableText("手机号", true)),
        TableCell(child: TableText("邮箱", true)),
        TableCell(child: TableText("认证状态", true)),
        TableCell(child: TableText("状态", true)),
        TableCell(child: TableText("操作", true)),
      ],
    );
  }

  TableRow buildTableRow(AccountOwnerController ctr) {
    return TableRow(
      decoration:
          BoxDecoration(color: const Color(0xFF3871BB).withOpacity(0.2)),
      children: const [
        TableCell(child: TableSelect()),
        TableCell(child: TableText("40001", false)),
        TableCell(child: TableText("13000000000", false)),
        TableCell(child: TableText("53646@kk.com", false)),
        TableCell(child: TableText("认证状态", false)),
        TableCell(child: TableText("状态", false)),
        TableCell(child: TableText("操作", false)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: GetBuilder<AccountOwnerController>(
        id: "user-table",
        builder: (ctr) => Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            1: MaxColumnWidth(FixedColumnWidth(50.0), FractionColumnWidth(0.1)),
            2: MaxColumnWidth(
                FixedColumnWidth(100.0), FractionColumnWidth(0.2)),
            3: MaxColumnWidth(
                FixedColumnWidth(100.0), FractionColumnWidth(0.2)),
            4: MaxColumnWidth(
                FixedColumnWidth(100.0), FractionColumnWidth(0.2)),
            5: MaxColumnWidth(FixedColumnWidth(80.0), FractionColumnWidth(0.1)),
            6: MaxColumnWidth(FixedColumnWidth(80.0), FractionColumnWidth(0.1)),
            7: MaxColumnWidth(FixedColumnWidth(80.0), FractionColumnWidth(0.1)),
          },
          children: [
            buildTableTitle(ctr),
            ...List.generate(10, (i) => buildTableRow(ctr))
          ],
        ),
      ),
    );
  }
}
