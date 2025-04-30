import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:encrypt/encrypt.dart';
import 'package:logger/logger.dart';

enum AppEnv { DEV, TST, LIN }

class AppConstants {
  /// 环境配置
  ///
  /// 分别为本地 测试 线上
  static const AppEnv appEnv = AppEnv.TST;

  /// http请求的host
  static final Map<AppEnv, String> _httpLink = {
    AppEnv.DEV: "http://192.168.101.25:8090",
    AppEnv.TST: "http://64.181.205.24:8090",
    AppEnv.LIN: "https://backhub.topinx.com",
  };
  static get httpLink => _httpLink[appEnv];

  /// 资源地址
  static final Map<AppEnv, String> _assetsLink = {
    AppEnv.DEV: "https://my-worker.iosdevelope.workers.dev/",
    AppEnv.TST: "https://my-worker.iosdevelope.workers.dev/",
    AppEnv.LIN: "https://oss.topinx.com/",
  };
  static get assetsLink => _assetsLink[appEnv];

  /// 资源地址
  static final Map<AppEnv, String> _jwtKey = {
    AppEnv.DEV: "secretKey",
    AppEnv.TST: "secretKey",
    AppEnv.LIN: "b0bb5c0474eafd36f7556",
  };
  static final jwt = JWT({'app': "com.hotspot.client.topinx"});

  static String signToken() {
    String token = jwt.sign(SecretKey(_jwtKey[appEnv]!),
        algorithm: JWTAlgorithm.HS256, expiresIn: const Duration(seconds: 30));

    return "Bearer $token";
  }

  /// pem
  static final Map<AppEnv, String> _passwordPem = {
    AppEnv.DEV: '''
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC90FUsMRCrNH1kjzRTUJdRwUcufXXZ449ePwKke1m/q9KuCtQIe0bTPKrD55MoLU1k8fa9J0dH3tyPE5bB/zm7Oayt8s8LAG5jbukkkABztxK7jCKWB9ObXx0atfZ7yWnthBGI070IW3ojOKSVSlY4xKc8wm2ODuDRawmF6zMoowIDAQAB
-----END PUBLIC KEY-----
  ''',
    AppEnv.TST: '''
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC90FUsMRCrNH1kjzRTUJdRwUcufXXZ449ePwKke1m/q9KuCtQIe0bTPKrD55MoLU1k8fa9J0dH3tyPE5bB/zm7Oayt8s8LAG5jbukkkABztxK7jCKWB9ObXx0atfZ7yWnthBGI070IW3ojOKSVSlY4xKc8wm2ODuDRawmF6zMoowIDAQAB
-----END PUBLIC KEY-----
  ''',
    AppEnv.LIN: '''
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCgQvkfgwcjbGDlE2tx3GqoNjKjYCyZPV/mf2GL285FPvbTE1XaLKLRaMnEk6ZLXCSRfYdU4xDy41VFwyNeowSnTlFC6V8RGj5bUtig7GaUbJ8hxocIVNF4IEo7lgdTYVpZFrtAwIn84dW4yTlHs96M4l9NtgfN4jhQW5HJZlW6pwIDAQAB
-----END PUBLIC KEY-----
  ''',
  };

  static get passwordPem => _passwordPem[appEnv];

  static String encryptPassword(String input) {
    dynamic parser = RSAKeyParser().parse(passwordPem);
    final encrypt = Encrypter(RSA(publicKey: parser));
    return encrypt.encrypt(input).base64;
  }

  static Logger _debug = Logger();
  static debugError(data) => _debug.e(data);
  static debugInfo(data) => _debug.i(data);
}
