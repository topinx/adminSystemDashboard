part of 'async_table.dart';

typedef AsyncBuilder<T> = ({String key, List<Widget> widgetList}) Function(T);

typedef AsyncFuture<T> = Future<List<T>> Function(int page, int limit);

enum AsyncTableStatus { LOADING, DONE, EMPTY }

class AsyncTableController<T> {
  _AsyncDataController<T> _dataCtr = _AsyncDataController<T>();
  _AsyncPageController _pageCtr = _AsyncPageController();
  ValueNotifier<AsyncTableStatus> _status =
      ValueNotifier(AsyncTableStatus.LOADING);

  void dispose() {
    _dataCtr.dispose();
    _pageCtr.dispose();
    _status.dispose();
  }

  /// 获取数据 int page int limit
  AsyncFuture<T>? _future;

  /// 更新数据总量 dataLen > 0 展示分页符
  void updateDataLen(int value) => _pageCtr._updateLen(value);
  int get dataLen => _pageCtr.dataLen;

  void initialize({required List<String> columns, AsyncFuture<T>? future}) {
    _dataCtr.columns = columns;
    _future = future;
  }

  /// 选择当页所有
  void onSelectAll() => _dataCtr.onTapSelectAll();

  /// 取消当前页所有选择
  void onUnselectAll() => _dataCtr.onTapUnselectAll();

  List<T> get selection => _dataCtr.selection;

  /// 拉取数据 传入page拉取指定页面数据 否则重新拉取当前页面数据
  Future<void> fetchData({int? page}) async {
    if (page != null) {
      if (!_pageCtr._canFetch(page)) return;
      _pageCtr._updatePage(page);
    }
    int pageIndex = _pageCtr.page;
    int pageLimit = _pageCtr.limit;
    if (_future == null) return;

    if (_status.value != AsyncTableStatus.LOADING) {
      _status.value = AsyncTableStatus.LOADING;
    }

    List<T> tempList = await _future!(pageIndex, pageLimit);
    _dataCtr._onFetchData(tempList);

    if (tempList.isEmpty) {
      _status.value = AsyncTableStatus.EMPTY;
    } else {
      _status.value = AsyncTableStatus.DONE;
    }
  }
}

class _AsyncDataController<T> extends ChangeNotifier {
  /// 标题列表
  List<String> _columns = [];
  set columns(List<String> temp) {
    assert(temp.isNotEmpty, "标题列表不能为空");
    _columns = temp;
  }

  /// 当页数据列表
  final List<T> _dataList = [];

  int get dataRowLen => _dataList.length;

  bool? get isAllSelected {
    if (_selection.isEmpty) return false;
    if (_selection.length == _dataList.length) return true;
    return null;
  }

  List<T> _selection = [];
  List<T> get selection => _selection;

  T rowData(int row) => _dataList[row];

  bool _isRowSelected(T bean) => _selection.contains(bean);

  void onTapSelectAll() {
    _selection.clear();
    _selection.addAll(_dataList);
    notifyListeners();
  }

  void onTapUnselectAll() {
    _selection.clear();
    notifyListeners();
  }

  void _onAllSelected(_) {
    if (_selection.length == _dataList.length) {
      _selection.clear();
      notifyListeners();
    } else {
      _selection.clear();
      _selection.addAll(_dataList);
      notifyListeners();
    }
  }

  void _onRowSelected(bool? select, T bean) {
    if (select == null) return;

    if (select && !_selection.contains(bean)) {
      _selection.add(bean);
      notifyListeners();
    } else if (!select && _selection.contains(bean)) {
      _selection.remove(bean);
      notifyListeners();
    }
  }

  void _onFetchData(List<T> temp) {
    _selection.clear();
    _dataList.clear();
    _dataList.addAll(temp);
    notifyListeners();
  }
}

class _AsyncPageController extends ChangeNotifier {
  int dataLen = 0;

  int page = 1;

  int limit = 10;

  int get pageLen => (dataLen / limit).ceil();

  void _updateLen(int value) {
    if (dataLen == value) return;
    dataLen = value;
    notifyListeners();
  }

  bool _canFetch(int index) => index >= 1 && index <= pageLen;

  void _updatePage(int index) {
    if (page == index || !_canFetch(index)) return;
    page = index;
    notifyListeners();
  }
}
