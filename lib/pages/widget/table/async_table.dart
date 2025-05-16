import 'package:flutter/material.dart';
import 'package:top_back/constants/app_constants.dart';
import 'package:top_back/pages/widget/common.dart';

part 'async_table_controller.dart';
part 'async_table_widget.dart';
part 'async_indicator.dart';

class AsyncTable<T> extends StatelessWidget {
  const AsyncTable({super.key, required this.ctr, required this.builder});

  final AsyncTableController ctr;

  /// 每个cell的最大高度56 最大宽度180
  final AsyncBuilder<T> builder;

  Widget buildCheckbox({
    required String key,
    required bool? checked,
    required VoidCallback? onRowTap,
    required ValueChanged<bool?>? onSelect,
    required bool status,
  }) {
    Widget contents = Checkbox(
      value: checked,
      onChanged: onSelect,
      tristate: status,
      side: BorderSide(width: 1, color: Colors.black12),
    );

    contents = Padding(
      padding: EdgeInsetsDirectional.only(start: 2, end: 2),
      child: Center(child: contents),
    );

    if (onRowTap != null) {
      contents = TableRowInkWell(onTap: onRowTap, child: contents);
    }
    return TableCell(
      key: ValueKey("check-$key"),
      verticalAlignment: TableCellVerticalAlignment.fill,
      child: contents,
    );
  }

  Widget buildDragBox(int rowIndex, String key, {bool isHeading = false}) {
    Widget contents = isHeading
        ? const SizedBox()
        : Row(children: [
            if (rowIndex > 0)
              IconButton(
                onPressed: () => ctr._dataCtr.moveUp(rowIndex),
                iconSize: 20,
                tooltip: "上移",
                padding: EdgeInsets.zero,
                icon: Icon(Icons.keyboard_double_arrow_up,
                    color: Colors.black12, weight: 1),
              ),
            if (rowIndex < ctr._dataCtr.dataRowLen - 1)
              IconButton(
                onPressed: () => ctr._dataCtr.moveDown(rowIndex),
                iconSize: 20,
                tooltip: "下移",
                padding: EdgeInsets.zero,
                icon: Icon(Icons.keyboard_double_arrow_down,
                    color: Colors.black12, weight: 1),
              )
          ]);

    contents = Padding(
      padding: EdgeInsetsDirectional.only(start: 5, end: 5),
      child: Center(child: contents),
    );

    return TableCell(
      key: ValueKey("drag-$key"),
      verticalAlignment: TableCellVerticalAlignment.fill,
      child: contents,
    );
  }

  Widget buildHeadingCell(String text) {
    return Container(
      height: 56,
      padding: EdgeInsetsDirectional.only(start: 2, end: 2),
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }

  Widget buildDataCell({required Widget cell, VoidCallback? onRowTap}) {
    return TableRowInkWell(
      onTap: onRowTap,
      child: Container(
        height: 56,
        constraints: BoxConstraints(maxWidth: 180),
        alignment: Alignment.center,
        child: cell,
      ),
    );
  }

  Widget buildDataTable() {
    final int columnsLen = ctr._dataCtr._columns.length;
    final int rowsLen = ctr._dataCtr.dataRowLen;

    final headKey = ValueKey(ctr._dataCtr._columns.join(""));

    List<TableColumnWidth> columnWidths = List<TableColumnWidth>.filled(
        columnsLen + 1, const IntrinsicColumnWidth(flex: 1));

    double size = Checkbox.width * (ctr._dataCtr._sortStatus ? 4 : 1);
    columnWidths[0] = FixedColumnWidth(12 + size + 12);

    List<TableRow> tableRows = [
      /// 先插入表头
      TableRow(
        key: headKey,
        decoration: BoxDecoration(color: Colors.black12),
        children: List<Widget>.filled(columnWidths.length, Text("")),
      ),
    ];

    /// 给表头插入checkbox
    tableRows[0].children[0] = ctr._dataCtr._sortStatus
        ? buildDragBox(0, "head", isHeading: true)
        : buildCheckbox(
            key: "head",
            checked: ctr._dataCtr.isAllSelected,
            onRowTap: null,
            onSelect: ctr._dataCtr._onAllSelected,
            status: true,
          );

    for (int columnIndex = 0; columnIndex < columnsLen; columnIndex++) {
      final int column = columnIndex + 1;

      String heading = ctr._dataCtr._columns[columnIndex];
      tableRows[0].children[column] = buildHeadingCell(heading);
    }

    for (int rowIndex = 0; rowIndex < rowsLen; rowIndex++) {
      final T bean = ctr._dataCtr.rowData(rowIndex);
      bool selected = ctr._dataCtr._isRowSelected(bean);

      var builderData = builder(ctr._dataCtr.rowData(rowIndex));
      String key = builderData.key;
      List<Widget> cellList = builderData.widgetList;

      final tableRow = TableRow(
        key: ValueKey(key),
        children: List<Widget>.filled(columnsLen + 1, NullWidget()),
      );

      tableRow.children[0] = ctr._dataCtr._sortStatus
          ? buildDragBox(rowIndex, key)
          : buildCheckbox(
              checked: selected,
              key: key,
              onRowTap: () => ctr._dataCtr._onRowSelected(!selected, bean),
              onSelect: (s) => ctr._dataCtr._onRowSelected(s, bean),
              status: false,
            );

      for (int columnIndex = 0; columnIndex < columnsLen; columnIndex++) {
        final int column = columnIndex + 1;

        tableRow.children[column] = buildDataCell(
          cell: cellList[columnIndex],
          onRowTap: () => ctr._dataCtr._onRowSelected(!selected, bean),
        );
      }

      tableRows.add(tableRow);
    }

    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.none,
      child: Table(
        columnWidths: columnWidths.asMap(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: tableRows,
      ),
    );
  }

  Widget buildIndicator() {
    return Visibility(
      visible: ctr._pageCtr.dataLen > 0 && !ctr._pageCtr._sortStatus,
      child: AsyncIndicator(
        onTap: (i) => ctr.fetchData(page: i),
        cur: ctr._pageCtr.page,
        dataLen: ctr._pageCtr.dataLen,
        pageLen: ctr._pageCtr.pageLen,
      ),
    );
  }

  Widget buildAsyncTableContent() {
    return Stack(fit: StackFit.passthrough, children: [
      ListenableBuilder(
        listenable: ctr._dataCtr,
        builder: (_, __) => buildDataTable(),
      ),
      ListenableBuilder(
        listenable: ctr._pageCtr,
        builder: (_, __) =>
            Positioned(left: 0, right: 0, bottom: 0, child: buildIndicator()),
      ),
      ListenableBuilder(
        listenable: ctr._status,
        builder: (_, __) => switch (ctr._status.value) {
          AsyncTableStatus.LOADING => const AsyncLoading(),
          AsyncTableStatus.DONE => const Center(),
          AsyncTableStatus.EMPTY => const AsyncEmpty(),
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      return SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: constraints.maxWidth),
          child: buildAsyncTableContent(),
        ),
      );
    });
  }
}

class NullWidget extends Widget {
  const NullWidget();

  @override
  Element createElement() => throw UnimplementedError();
}
