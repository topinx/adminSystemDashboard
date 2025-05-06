import 'package:top_back/constants/app_storage.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 账号搜索条件
class AccountSearchParam {
  String nick;

  String phone;

  String email;

  /// 账号状态 0 全部 1 正常使用 2 已停用
  /// param value 1 正常 0 停用
  int state_a;

  /// 认证状态 0 全部 1 普通用户 2 认证博主 3 认证商户
  /// param value 1 普通 2 博主 3 商户
  int state_v;

  int? get state_a_param {
    if (state_a == 1) return 1;
    if (state_a == 2) return 0;
    return null;
  }

  int? get state_v_param {
    if (state_v > 0) return state_v;
    return null;
  }

  AccountSearchParam({
    this.nick = "",
    this.phone = "",
    this.email = "",
    this.state_a = 0,
    this.state_v = 0,
  });

  AccountSearchParam copyWith({
    String? nick,
    String? phone,
    String? email,
    int? state_a,
    int? state_v,
  }) {
    return AccountSearchParam(
      nick: nick ?? this.nick,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      state_a: state_a ?? this.state_a,
      state_v: state_v ?? this.state_v,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountSearchParam &&
          runtimeType == other.runtimeType &&
          nick == other.nick &&
          phone == other.phone &&
          email == other.email &&
          state_a == other.state_a &&
          state_v == other.state_v;

  @override
  int get hashCode => Object.hash(nick, phone, email, state_a, state_v);
}

class AccountSearchParamProvider extends StateNotifier<AccountSearchParam> {
  AccountSearchParamProvider() : super(AccountSearchParam());

  void defParam() {
    state = state.copyWith(
      nick: "",
      phone: "",
      email: "",
      state_a: 0,
      state_v: 0,
    );
  }
}

final accountSearchParam =
    StateNotifierProvider<AccountSearchParamProvider, AccountSearchParam>(
  (ref) => AccountSearchParamProvider(),
);

final accountCnt1 = FutureProvider<int>(
  (ref) async {
    return await DioRequest().request(HttpConstant.accountCnt,
        query: {"userId": Storage().user.userId});
  },
);

final accountCnt2 = FutureProvider<int>(
  (ref) async {
    return await DioRequest().request(HttpConstant.accountCnt);
  },
);
