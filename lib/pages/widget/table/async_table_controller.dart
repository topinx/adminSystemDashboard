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

  /// 更新到拖拽排序状态
  void updateToSort(bool sort) {
    _dataCtr.updateToSort(sort);
    _pageCtr.updateToSort(sort);
  }

  /// 选中的表格
  List<T> get selection => _dataCtr._selection;

  /// 排序后的数据
  List<T> get sortList => _dataCtr._sortList;

  /// 当页数据列表
  List<T> get dataList => _dataCtr._dataList;

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
      if (_status.value == AsyncTableStatus.EMPTY) return;
      _status.value = AsyncTableStatus.EMPTY;
    } else {
      if (_status.value == AsyncTableStatus.DONE) return;
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

  final List<T> _sortList = [];

  int get dataRowLen => _dataList.length;

  bool? get isAllSelected {
    if (_dataList.isEmpty) return false;
    if (_selection.isEmpty) return false;
    if (_selection.length == _dataList.length) return true;
    return null;
  }

  List<T> _selection = [];

  bool _isRowSelected(T bean) => _selection.contains(bean);

  void onTapSelectAll() {
    if (_dataList.isEmpty) return;
    if (_selection.length == _dataList.length) return;

    _selection.clear();
    _selection.addAll(_dataList);
    notifyListeners();
  }

  void onTapUnselectAll() {
    if (_selection.isEmpty) return;

    _selection.clear();
    notifyListeners();
  }

  void _onAllSelected(_) {
    if (_dataList.isEmpty) return;

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
    _sortList.clear();
    _sortStatus = false;

    _dataList.clear();
    _dataList.addAll(temp);
    notifyListeners();
  }

  T rowData(int row) => _sortStatus ? _sortList[row] : _dataList[row];

  /// 是否是排序状态
  bool _sortStatus = false;

  void updateToSort(bool sort) {
    if (sort == _sortStatus) return;

    _selection.clear();
    _sortList.clear();
    _sortStatus = sort;

    if (_sortStatus) {
      _sortList.addAll(_dataList);
    }

    notifyListeners();
  }

  void moveUp(int row) {
    if (row == 0) return;

    final temp = _sortList[row - 1];
    _sortList[row - 1] = _sortList[row];
    _sortList[row] = temp;
    notifyListeners();
  }

  void moveDown(int row) {
    if (row == _sortList.length - 1) return;

    final temp = _sortList[row + 1];
    _sortList[row + 1] = _sortList[row];
    _sortList[row] = temp;
    notifyListeners();
  }
}

class _AsyncPageController extends ChangeNotifier {
  int dataLen = 0;

  int page = 1;

  int limit = 10;

  bool _sortStatus = false;

  void updateToSort(bool drag) {
    if (drag == _sortStatus) return;

    _sortStatus = drag;
    notifyListeners();
  }

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
