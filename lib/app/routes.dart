// ignore_for_file: non_constant_identifier_names

part of "pages.dart";

abstract class Routes {
  static const unknown = _Paths.unknown;
  static const login = _Paths.login;
  static String LOGIN_THEN(String after) =>
      '$login?then=${Uri.encodeQueryComponent(after)}';

  static const home = _Paths.home;
  static const homeEmpty = home + _Paths.homeEmpty;

  static const accountManage = home + _Paths.accountManage;
  static const accountOwner = home + _Paths.accountOwner;
  static String ACCOUNT_INFO(String userId) => '$home/accountInfo/$userId';
  static String ACCOUNT_NOTE(String userId) => '$home/accountNote/$userId';

  static const manageNote = home + _Paths.manageNote;
  static const manageTopic = home + _Paths.manageTopic;
  static const manageEmoji = home + _Paths.manageEmoji;
  static const manageClassify = home + _Paths.manageClassify;
  static const manageRecord = home + _Paths.manageRecord;

  static const searchManage = home + _Paths.searchManage;

  static const pubRecommend = home + _Paths.pubRecommend;
  static const pubCreative = home + _Paths.pubCreative;
  static String PUBLISH(int id, int type) => '$home/publish/$id/$type';

  static const reportUser = home + _Paths.reportUser;
  static const reportNote = home + _Paths.reportNote;

  Routes._();
}

abstract class _Paths {
  static const unknown = '/unknown';
  static const login = '/login';

  static const home = '/home';
  static const homeEmpty = '/homeEmpty';

  static const accountManage = '/accountManage';
  static const accountOwner = '/accountOwner';
  static const accountInfo = '/accountInfo/:userId';
  static const accountNote = '/accountNote/:userId';

  static const manageNote = '/manageNote';
  static const manageTopic = '/manageTopic';
  static const manageEmoji = '/manageEmoji';
  static const manageClassify = '/manageClassify';
  static const manageRecord = '/manageRecord';

  static const searchManage = "/searchManage";

  static const pubRecommend = "/pubRecommend";
  static const pubCreative = "/pubCreative";
  static const publish = "/publish/:id/:type";

  static const reportUser = "/reportUser";
  static const reportNote = "/reportNote";
}
