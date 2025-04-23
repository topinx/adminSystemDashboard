import 'package:top_back/bean/bean_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final Storage _instance = Storage._();
  Storage._();
  factory Storage() => _instance;

  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  /// 用户登录消息
  ///
  /// 用户角色 2:员工/1:管理员/-1:超管
  BeanUser user = BeanUser();

  String get bearToken => "Bearer ${user.token}";

  Future<void> init() async {
    String? bean = await asyncPrefs.getString("user");
    if (bean == null) return;
    user = beanUserFromJson(bean);
  }

  void saveUserToStorage() {
    asyncPrefs.setString("user", beanUserToJson(user));
  }

  void clearUserInfo() {
    user = BeanUser();
    asyncPrefs.remove("user");
  }
}
