// ignore_for_file: non_constant_identifier_names

part of "pages.dart";

abstract class Routes {
  static const login = _Paths.login;
  static String LOGIN_THEN(String after) =>
      '$login?then=${Uri.encodeQueryComponent(after)}';

  static const home = _Paths.home;

  static const accountEmpty = home + _Paths.accountEmpty;
  static const accountCreate = home + _Paths.accountCreate;
  static const accountManage = home + _Paths.accountManage;
  static const accountOwner = home + _Paths.accountOwner;

  static String ACCOUNT_INFO(int userId) => '$home/accountInfo/id=$userId';
  static String ACCOUNT_NOTE(int userId) => '$home/accountNote/id=$userId';

  static const manageNote = home + _Paths.manageNote;
  static const manageTopic = home + _Paths.manageTopic;
  static const manageEmoji = home + _Paths.manageEmoji;
  static const manageClassify = home + _Paths.manageClassify;
  static const manageRecord = home + _Paths.manageRecord;

  static const searchManage = home + _Paths.searchManage;

  static const pubRecommend = home + _Paths.pubRecommend;
  static const pubCreative = home + _Paths.pubCreative;
  static String PUBLISH(BigInt id, int type) =>
      '$home/publish/id=$id/type=$type';
  static String NOTE_DETAIL(BigInt id) => '$home/noteDetail/id=$id';

  static const reportUser = home + _Paths.reportUser;
  static const reportNote = home + _Paths.reportNote;

  Routes._();
}

abstract class _Paths {
  static const login = '/login';
  static const home = '/home';

  static const accountManage = '/account/manage';
  static const accountOwner = '/account/accounts';

  static const accountEmpty = '/accountEmpty';
  static const accountCreate = '/accountCreate';
  static const accountInfo = '/accountInfo/id=:userId';
  static const accountNote = '/accountNote/id=:userId';

  static const manageNote = '/manageNote';
  static const manageTopic = '/manageTopic';
  static const manageEmoji = '/manageEmoji';
  static const manageClassify = '/manageClassify';
  static const manageRecord = '/manageRecord';

  static const searchManage = "/searchManage";

  static const pubRecommend = "/pubRecommend";
  static const pubCreative = "/pubCreative";
  static const publish = "/publish/id=:id/type=:type";
  static const noteDetail = "/noteDetail/id=:id";

  static const reportUser = "/reportUser";
  static const reportNote = "/reportNote";
}
