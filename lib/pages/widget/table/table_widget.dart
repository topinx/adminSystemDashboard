import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:top_back/constants/app_constants.dart';
import 'package:top_back/pages/widget/common.dart';

part 'table_controller.dart';
part 'table_empty.dart';
part 'table_indicator.dart';

class TableWidget<T> extends StatelessWidget {
  const TableWidget({
    super.key,
    required this.columns,
    required this.controller,
  });

  final List<String> columns;

  final TableController<T> controller;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      AsyncPaginatedDataTable2(
        horizontalMargin: 20,
        dividerThickness: 0,
        checkboxHorizontalMargin: 20,
        columnSpacing: 0,
        controller: controller.pageCtr,
        wrapInCard: false,
        showCheckboxColumn: true,
        headingCheckboxTheme: CheckboxThemeData(
            side: BorderSide(color: Colors.black12, width: 1)),
        datarowCheckboxTheme: CheckboxThemeData(
            side: BorderSide(color: Colors.black12, width: 1)),
        renderEmptyRowsInTheEnd: false,
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.black12),
        rowsPerPage: PaginatedDataTable.defaultRowsPerPage,
        autoRowsToHeight: false,
        minWidth: 800,
        loading: const TabLoading(),
        fit: FlexFit.tight,
        hidePaginator: true,
        initialFirstRowIndex: 0,
        empty: const TabEmpty(),
        errorBuilder: (error) => CommonError(error ?? ""),
        columns: columns
            .map((x) => DataColumn2(label: Center(child: Text(x))))
            .toList(),
        source: controller,
        onSelectAll: controller.onSelectAll,
      ),
      Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: TableIndicator(controller.pageCtr)),
    ]);
  }
}
