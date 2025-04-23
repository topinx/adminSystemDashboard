import 'package:top_back/bean/bean_account.dart';
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

  void updateParam({
    String? nick,
    String? phone,
    String? email,
    int? state_a,
    int? state_v,
  }) {
    state = state.copyWith(
      nick: nick,
      phone: phone,
      email: email,
      state_a: state_a,
      state_v: state_v,
    );
  }

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

final accountCntProvider = FutureProvider<int>(
  (ref) async {
    return await DioRequest().request(
      HttpConstant.accountCnt,
      query: {"userId": Storage().user.userId},
    );
  },
);

final accountProvider = AsyncNotifierProvider<AccountListNotifier,
    ({List<BeanAccount> beanList, int count})>(
  AccountListNotifier.new,
);

class AccountListNotifier
    extends AsyncNotifier<({List<BeanAccount> beanList, int count})> {
  int pageIndex = 1;

  @override
  Future<({List<BeanAccount> beanList, int count})> build() async {
    return fetchList();
  }

  Future<({List<BeanAccount> beanList, int count})> fetchList() async {
    final param = ref.read(accountSearchParam);

    final query = {
      "pageNo": pageIndex,
      "limit": 10,
      "userId": Storage().user.userId,
      "nickname": param.nick,
      "phone": param.phone,
      "email": param.email,
      "status": param.state_a_param,
      "authenticationStatus": param.state_v_param,
    };

    final response = await Future.wait([
      DioRequest().request(HttpConstant.accountList, query: query),
      DioRequest().request(HttpConstant.accountCnt, query: query),
    ]);

    pageIndex = response[0]["pageNo"];

    final tempList = response[0]["list"] ?? [];
    List<BeanAccount> beanList = List<BeanAccount>.from(
      tempList.map((x) => BeanAccount.fromJson(x)),
    );

    int count = response[1] ?? 0;

    return (beanList: beanList, count: count);
  }

  /// 刷新数据
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => fetchList());
  }

  /// 加载下一页
  Future<void> loadNext({int? page}) async {
    if (page != null) {
      pageIndex = page;
    }
    final response = await fetchList();
    state = AsyncValue.data(response);
  }
}
