import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchSort {
  bool isAuto = true;

  bool isSorting = false;

  SearchSort({this.isAuto = true, this.isSorting = false})
      : assert(!(isAuto && isSorting));

  SearchSort copyWith({bool? isAuto, bool? isSorting}) {
    return SearchSort(
        isAuto: isAuto ?? this.isAuto, isSorting: isSorting ?? this.isSorting);
  }
}

class SearchSortProvider extends StateNotifier<SearchSort> {
  SearchSortProvider() : super(SearchSort());

  void switchToAuto(bool auto) {
    if (auto == state.isAuto) return;

    state = state.copyWith(isAuto: auto);
  }

  void switchSortStatus() {
    bool sort = state.isSorting;

    state = state.copyWith(isSorting: !sort);
  }
}

final searchSortProvider =
    StateNotifierProvider.autoDispose<SearchSortProvider, SearchSort>(
        (ref) => SearchSortProvider());
