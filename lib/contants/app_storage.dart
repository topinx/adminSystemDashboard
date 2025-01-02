import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_back/bean/bean_login.dart';

class AppStorage {
  static final AppStorage _instance = AppStorage._();
  AppStorage._();
  factory AppStorage() => _instance;

  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  /// 用户登录消息
  ///
  /// 用户角色 2:员工/1:管理员/-1:超管
  BeanLogin beanLogin = BeanLogin.empty();

  Future<void> init() async {
    String? bean = await asyncPrefs.getString("user");
    if (bean == null) return;
    beanLogin = beanLoginFromJson(bean);
  }

  void saveUserFromHttp(data) {
    beanLogin = BeanLogin.fromJson(data);
    asyncPrefs.setString("user", beanLoginToJson(beanLogin));
  }

  void updateUserToken(data) {
    beanLogin.token = data;
    asyncPrefs.setString("user", beanLoginToJson(beanLogin));
  }

  void clearUserInfo() {
    beanLogin = BeanLogin.empty();
    asyncPrefs.remove("user");
  }
}
