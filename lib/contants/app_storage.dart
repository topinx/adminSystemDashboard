class AppStorage {
  static final AppStorage _instance = AppStorage._();
  AppStorage._();
  factory AppStorage() => _instance;

  String token = "";
}
