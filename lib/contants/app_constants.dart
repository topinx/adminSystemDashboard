enum AppEnv { onLocal, onTest, onLine }

class AppConstants {
  /// 环境配置
  ///
  /// 分别为本地 测试 线上
  static const AppEnv appEnv = AppEnv.onTest;

  /// http请求的host
  static final Map<AppEnv, String> _httpLink = {
    AppEnv.onLocal: "http://192.168.101.25:8090",
    AppEnv.onTest: "http://35.225.142.214:8090",
    AppEnv.onLine: "",
  };
  static get httpLink => _httpLink[appEnv];

  /// socket长连接的host
  static final Map<AppEnv, String> _socketLink = {
    AppEnv.onLocal: "",
    AppEnv.onTest: "",
    AppEnv.onLine: "",
  };
  static get socketLink => _socketLink[appEnv];

  static get imgLink =>
      httpLink + "/adminsystem/system/file/download?objectName=";
}
