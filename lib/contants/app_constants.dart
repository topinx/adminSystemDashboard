import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

enum AppEnv { onLocal, onTest, onLine }

class AppConstants {
  /// 环境配置
  ///
  /// 分别为本地 测试 线上
  static const AppEnv appEnv = AppEnv.onTest;

  /// http请求的host
  static final Map<AppEnv, String> _httpLink = {
    AppEnv.onLocal: "http://192.168.101.25:8090",
    AppEnv.onTest: "http://64.181.205.24:8090",
    AppEnv.onLine: "",
  };
  static get httpLink => _httpLink[appEnv];

  /// 资源地址
  static final Map<AppEnv, String> _assetsLink = {
    AppEnv.onLocal: "https://my-worker.iosdevelope.workers.dev/",
    AppEnv.onTest: "https://my-worker.iosdevelope.workers.dev/",
    AppEnv.onLine: "",
  };
  static get assetsLink => _assetsLink[appEnv];

  static final jwt = JWT({'app': "com.hotspot.client.topinx"});

  static String signToken() {
    String token = jwt.sign(
      SecretKey('secretKey'),
      algorithm: JWTAlgorithm.HS256,
      expiresIn: const Duration(seconds: 30),
    );

    return "Bearer $token";
  }
}
