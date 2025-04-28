part of 'table_widget.dart';

typedef TabBuilder<T> = ({String key, List<Widget> widgetList}) Function(T);

typedef AsyncFuture<T> = Future<List<T>> Function(int page);

class TableController<T> extends AsyncDataTableSource {
  int dataLen = 0;

  late TabBuilder<T?> builder;

  late AsyncFuture<T> future;

  PaginatorController pageCtr = PaginatorController();

  @override
  void dispose() {
    pageCtr.dispose();
    super.dispose();
  }

  @override
  int get rowCount => dataLen;

  @override
  bool get isRowCountApproximate => false;

  List<T> _dataList = [];

  List<T> _selection = [];
  List<T> get selection => _selection;

  void onTapSelect(String key, T bean, bool? select) {
    if (select == null) return;
    setRowSelection(ValueKey(key), select);

    if (select && !_selection.contains(bean)) {
      _selection.add(bean);
    } else if (!select && _selection.contains(bean)) {
      _selection.remove(bean);
    }
  }

  void onSelectAll(bool? select) {
    if (select == null) return;

    if (select) {
      _selection.clear();
      _selection.addAll(_selection);
      selectAllOnThePage();
    } else {
      deselectAllOnThePage();
      _selection.clear();
    }
  }

  DataRow2 buildRowWidget(T? bean) {
    var row = builder(bean);
    if (bean == null) {
      return DataRow2(
        cells: row.widgetList.map((x) => buildDataCell(x)).toList(),
      );
    }

    return DataRow2(
      key: ValueKey(row.key),
      onSelectChanged: (s) => onTapSelect(row.key, bean, s),
      cells: row.widgetList.map((x) => buildDataCell(x)).toList(),
    );
  }

  DataCell buildDataCell(Widget x) {
    return DataCell(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Center(child: x),
    ));
  }

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    if (dataLen == 0) {
      return AsyncRowsResponse(
        0,
        List.generate(0, (i) => buildRowWidget(null)),
      );
    }

    int page = startIndex ~/ count + 1;
    List<T> response = await future(page);

    _dataList.clear();
    _dataList.addAll(response);

    return AsyncRowsResponse(
      response.length,
      List.generate(response.length, (i) => buildRowWidget(response[i])),
    );
  }
}
