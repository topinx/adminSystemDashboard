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
      preventDuplicates: true,
      participatesInRootNavigator: true,
      name: _Paths.home,
      transition: Transition.fadeIn,
      page: () => const HomePage(),
      binding: HomeBinding(),
      // middlewares: [AuthMiddleware()],
      children: [
        GetPage(
          name: _Paths.accountManage,
          transition: Transition.rightToLeft,
          page: () => const AccountManageView(),
          binding: AccountManageBinding(),
        ),
        GetPage(
          name: _Paths.accountOwner,
          transition: Transition.rightToLeft,
          page: () => const AccountOwnerView(),
          binding: AccountOwnerBinding(),
        ),
        GetPage(
          name: _Paths.manageNote,
          transition: Transition.rightToLeft,
          page: () => const ManageNoteView(),
          binding: ManageNoteBinding(),
        ),
        GetPage(
          name: _Paths.manageTopic,
          transition: Transition.rightToLeft,
          page: () => const ManageTopicView(),
          binding: ManageTopicBinding(),
        ),
        GetPage(
          name: _Paths.manageEmoji,
          transition: Transition.rightToLeft,
          page: () => const ManageEmojiView(),
          binding: ManageEmojiBinding(),
        ),
        GetPage(
          name: _Paths.manageClassify,
          transition: Transition.rightToLeft,
          page: () => const ManageClassifyView(),
          binding: ManageClassifyBinding(),
        ),
        GetPage(
          name: _Paths.manageVerify,
          transition: Transition.rightToLeft,
          page: () => const ManageVerifyView(),
          binding: ManageVerifyBinding(),
        ),
        GetPage(
          name: _Paths.searchManage,
          transition: Transition.rightToLeft,
          page: () => const SearchManageView(),
          binding: SearchManageBinding(),
        ),
        GetPage(
          name: _Paths.pubRecommend,
          transition: Transition.rightToLeft,
          page: () => const PubRecommendView(),
          binding: PubRecommendBinding(),
        ),
        GetPage(
          name: _Paths.pubCreative,
          transition: Transition.rightToLeft,
          page: () => const PubCreativeView(),
          binding: PubCreativeBinding(),
        ),
        GetPage(
          name: _Paths.reportUser,
          transition: Transition.rightToLeft,
          page: () => const ReportUserView(),
          binding: ReportUserBinding(),
        ),
        GetPage(
          name: _Paths.reportNote,
          transition: Transition.rightToLeft,
          page: () => const ReportNoteView(),
          binding: ReportNoteBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.login,
      transition: Transition.fadeIn,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
