import 'package:top_back/bean/bean_topic.dart';
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
  errorBuilder: (_, state) => Material(
    child: Container(
        alignment: Alignment.center,
        child: Text("${state.uri.toString()} error")),
  ),
  routes: [
    GoRoute(
      path: RouterPath.path_login,
      builder: (context, state) => const LoginPage(),
    ),
    ShellRoute(builder: (_, state, child) => AdminPage(child), routes: [
      GoRoute(
        path: RouterPath.path_dashboard,
        pageBuilder: (c, s) => pageBuilder(c, s, const DashboardPage()),
      ),
      GoRoute(
        path: RouterPath.path_account_manager,
        pageBuilder: (c, s) => pageBuilder(c, s, const AccountManager()),
      ),
      GoRoute(
        path: RouterPath.path_account_owner,
        pageBuilder: (c, s) => pageBuilder(c, s, const AccountOwner()),
      ),
      GoRoute(
        path: RouterPath.path_manage_note,
        pageBuilder: (c, s) => pageBuilder(c, s, const ManageNote()),
      ),
      GoRoute(
        path: RouterPath.path_manage_topic,
        pageBuilder: (c, s) => pageBuilder(c, s, const ManageTopic()),
      ),
      GoRoute(
        path: RouterPath.path_manage_emoji,
        pageBuilder: (c, s) => pageBuilder(c, s, const ManageEmoji()),
      ),
      GoRoute(
        path: RouterPath.path_manage_classify,
        pageBuilder: (c, s) => pageBuilder(c, s, const ManageClassify()),
      ),
      GoRoute(
        path: RouterPath.path_manage_review,
        pageBuilder: (c, s) => pageBuilder(c, s, const ManageReview()),
      ),
      GoRoute(
        path: RouterPath.path_search_manage,
        pageBuilder: (c, s) => pageBuilder(c, s, const SearchManage()),
      ),
      GoRoute(
        path: RouterPath.path_pub_recommend,
        pageBuilder: (c, s) => pageBuilder(c, s, const PubRecommend()),
      ),
      GoRoute(
        path: RouterPath.path_pub_creative,
        pageBuilder: (c, s) => pageBuilder(c, s, const PubCreative()),
      ),
      GoRoute(
        path: RouterPath.path_report_user,
        pageBuilder: (c, s) => pageBuilder(c, s, const ReportUser()),
      ),
      GoRoute(
        path: RouterPath.path_report_note,
        pageBuilder: (c, s) => pageBuilder(c, s, const ReportNote()),
      ),
      GoRoute(
        path: RouterPath.path_account_info,
        pageBuilder: (c, s) =>
            pageBuilder(c, s, AccountInfo(s.pathParameters['id']!)),
      ),
      GoRoute(
        path: RouterPath.path_account_create,
        pageBuilder: (c, s) => pageBuilder(c, s, AccountCreate()),
      ),
      GoRoute(
        path: RouterPath.path_account_note,
        pageBuilder: (c, s) =>
            pageBuilder(c, s, AccountNote(s.pathParameters['id']!)),
      ),
      GoRoute(
        path: RouterPath.path_topic_create,
        pageBuilder: (c, s) =>
            dialogBuilder(c, s, TopicCreate(s.extra as BeanTopic?)),
      ),
    ]),
  ],
);
