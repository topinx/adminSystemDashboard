import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class TabColumn {
  String text;

  ColumnSize size = ColumnSize.M;

  TabColumn(this.text, [this.size = ColumnSize.M]);
}

class TabText extends StatelessWidget {
  const TabText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text.isEmpty ? "-" : text);
  }
}

typedef TabBuilder = Widget Function(int, int);

class TableRecord extends StatefulWidget {
  const TableRecord({
    super.key,
    required this.tabTitles,
    required this.builder,
    required this.dataLen,
  });

  final List<TabColumn> tabTitles;

  final TabBuilder builder;

  final int dataLen;

  @override
  State<TableRecord> createState() => _TableRecordState();
}

class _TableRecordState extends State<TableRecord> {
  late DataSource dataSource;

  @override
  void initState() {
    super.initState();
    dataSource =
        DataSource(widget.tabTitles.length, widget.dataLen, widget.builder);
  }

  @override
  void dispose() {
    super.dispose();
    dataSource.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable2(
      horizontalMargin: 0,
      dividerThickness: 0,
      checkboxHorizontalMargin: 20,
      columnSpacing: 0,
      wrapInCard: false,
      showCheckboxColumn: true,
      headingCheckboxTheme:
          CheckboxThemeData(side: BorderSide(color: Colors.black12, width: 1)),
      datarowCheckboxTheme:
          CheckboxThemeData(side: BorderSide(color: Colors.black12, width: 1)),
      renderEmptyRowsInTheEnd: false,
      headingRowColor: WidgetStateColor.resolveWith((states) => Colors.black12),
      rowsPerPage: PaginatedDataTable.defaultRowsPerPage,
      autoRowsToHeight: false,
      minWidth: 800,
      fit: FlexFit.tight,
      initialFirstRowIndex: 0,
      empty: const TableEmpty(),
      columns: widget.tabTitles
          .map((x) =>
              DataColumn2(label: Center(child: Text(x.text)), size: x.size))
          .toList(),
      source: dataSource,
    );
  }
}

class TableEmpty extends StatelessWidget {
  const TableEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.black12,
          child: const Text('Empty Data')),
    );
  }
}

class DataSource extends DataTableSource {
  final int rowLen;

  final TabBuilder builder;

  final int dataLen;

  DataSource(this.rowLen, this.dataLen, this.builder);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataLen;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) {
    return DataRow2(
      onSelectChanged: (value) {},
      cells: List.generate(
        rowLen,
        (column) => DataCell(Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Center(child: builder(column, index)))),
      ),
    );
  }
}
