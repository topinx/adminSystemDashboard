import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'auth_middleware.dart';
import 'pages/login/index.dart';
import 'pages/home/index.dart';
import 'pages/account/index.dart';
import 'pages/manage/index.dart';
import 'pages/report/index.dart';
import 'pages/search/index.dart';
import 'pages/publish/index.dart';

part 'routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      participatesInRootNavigator: true,
      name: _Paths.home,
      transition: Transition.noTransition,
      page: () => const HomePage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
      children: [
        GetPage(
          maintainState: false,
          name: _Paths.accountEmpty,
          transition: Transition.noTransition,
          page: () => Container(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.accountManage,
          transition: Transition.noTransition,
          page: () => const AccountManageView(),
          binding: AccountManageBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.accountOwner,
          transition: Transition.noTransition,
          page: () => const AccountOwnerView(),
          binding: AccountOwnerBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.accountCreate,
          transition: Transition.noTransition,
          page: () => const AccountCreateView(),
          binding: AccountCreateBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.accountInfo,
          transition: Transition.noTransition,
          page: () => const AccountInfoView(),
          binding: AccountInfoBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.accountNote,
          transition: Transition.noTransition,
          page: () => const AccountNoteView(),
          binding: AccountNoteBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.manageNote,
          transition: Transition.noTransition,
          page: () => const ManageNoteView(),
          binding: ManageNoteBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.manageTopic,
          transition: Transition.noTransition,
          page: () => const ManageTopicView(),
          binding: ManageTopicBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.manageEmoji,
          transition: Transition.noTransition,
          page: () => const ManageEmojiView(),
          binding: ManageEmojiBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.manageClassify,
          transition: Transition.noTransition,
          page: () => const ManageClassifyView(),
          binding: ManageClassifyBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.manageRecord,
          transition: Transition.noTransition,
          page: () => const ManageRecordView(),
          binding: ManageRecordBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.searchManage,
          transition: Transition.noTransition,
          page: () => const SearchTopicView(),
          binding: SearchTopicBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.pubRecommend,
          transition: Transition.noTransition,
          page: () => const PubRecommendView(),
          binding: PubRecommendBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.pubCreative,
          transition: Transition.noTransition,
          page: () => const PubCreativeView(),
          binding: PubCreativeBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.publish,
          transition: Transition.noTransition,
          page: () => const PublishView(),
          binding: PublishBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.noteDetail,
          transition: Transition.noTransition,
          page: () => const NoteDetailView(),
          binding: NoteDetailBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.reportUser,
          transition: Transition.noTransition,
          page: () => const ReportUserView(),
          binding: ReportUserBinding(),
        ),
        GetPage(
          maintainState: false,
          name: _Paths.reportNote,
          transition: Transition.noTransition,
          page: () => const ReportNoteView(),
          binding: ReportNoteBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.login,
      transition: Transition.noTransition,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
