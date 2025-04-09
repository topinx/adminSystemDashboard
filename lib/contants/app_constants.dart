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
    AppEnv.onLine: "http://149.130.217.142:8090",
  };
  static get httpLink => _httpLink[appEnv];

  /// 资源地址
  static final Map<AppEnv, String> _assetsLink = {
    AppEnv.onLocal: "https://my-worker.iosdevelope.workers.dev/",
    AppEnv.onTest: "https://my-worker.iosdevelope.workers.dev/",
    AppEnv.onLine: "https://my-worker-pro.iosdevelope.workers.dev/",
  };
  static get assetsLink => _assetsLink[appEnv];

  static final jwt = JWT({'app': "com.hotspot.client.topinx"});

  static String signToken() {
    String token = jwt.sign(
      SecretKey(
          appEnv == AppEnv.onLine ? "b0bb5c0474eafd36f7556" : 'secretKey'),
      algorithm: JWTAlgorithm.HS256,
      expiresIn: const Duration(seconds: 30),
    );

    return "Bearer $token";
  }
}
