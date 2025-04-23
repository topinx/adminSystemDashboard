import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension FirstWhereOrNullExt<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension CancelTokenRequest on Ref {
  CancelToken cancelToken() {
    final cancelToken = CancelToken();
    onDispose(cancelToken.cancel);
    return cancelToken;
  }
}
