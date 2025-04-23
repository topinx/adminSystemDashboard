import 'package:top_back/constants/app_storage.dart';
import 'package:top_back/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router_path.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: RouterPath.path_dashboard,
  navigatorKey: navigatorKey,
  redirect: (_, state) {
    final needLogin = Storage().user.token.isEmpty;
    final inLogin = state.uri.path == RouterPath.path_login;
    if (needLogin && !inLogin) return RouterPath.path_login;

    return null;
  },
  routes: [
    GoRoute(
      path: RouterPath.path_login,
      builder: (context, state) => const LoginPage(),
    ),
    ShellRoute(builder: (_, state, child) => AdminPage(child), routes: [
      GoRoute(
        path: RouterPath.path_dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: RouterPath.path_account_manager,
        builder: (context, state) => const AccountManager(),
      ),
      GoRoute(
        path: RouterPath.path_account_owner,
        builder: (context, state) => const AccountOwner(),
      ),
      GoRoute(
        path: RouterPath.path_manage_note,
        builder: (context, state) => const ManageNote(),
      ),
      GoRoute(
        path: RouterPath.path_manage_topic,
        builder: (context, state) => const ManageTopic(),
      ),
      GoRoute(
        path: RouterPath.path_manage_emoji,
        builder: (context, state) => const ManageEmoji(),
      ),
      GoRoute(
        path: RouterPath.path_manage_classify,
        builder: (context, state) => const ManageClassify(),
      ),
      GoRoute(
        path: RouterPath.path_manage_review,
        builder: (context, state) => const ManageReview(),
      ),
      GoRoute(
        path: RouterPath.path_search_manage,
        builder: (context, state) => const SearchManage(),
      ),
      GoRoute(
        path: RouterPath.path_pub_recommend,
        builder: (context, state) => const PubRecommend(),
      ),
      GoRoute(
        path: RouterPath.path_pub_creative,
        builder: (context, state) => const PubCreative(),
      ),
      GoRoute(
        path: RouterPath.path_report_user,
        builder: (context, state) => const ReportUser(),
      ),
      GoRoute(
        path: RouterPath.path_report_note,
        builder: (context, state) => const ReportNote(),
      ),
    ]),
  ],
);
