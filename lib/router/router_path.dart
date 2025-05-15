part of 'router.dart';

var pageBuilder = (context, state, page) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: page,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, anim, _, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      var tween = Tween(begin: begin, end: end);

      return SlideTransition(position: anim.drive(tween), child: child);
    },
  );
};

class RouterPath {
  static String path_login = "/login";

  static String path_dashboard = "/dashboard";

  static String path_account_manager = "/account_manager";
  static String path_account_owner = "/account_owner";

  static String path_manage_note = "/manage_note";
  static String path_manage_topic = "/manage_topic";
  static String path_manage_emoji = "/manage_emoji";
  static String path_manage_classify = "/manage_classify";
  static String path_manage_review = "/manage_review";

  static String path_search_manage = "/search_manage";

  static String path_pub_recommend = "/pub_recommend";
  static String path_pub_creative = "/pub_creative";

  static String path_report_user = "/report_user";
  static String path_report_note = "/report_note";

  static String path_account_info = "/account_info/:id";
  static String account_info(int id) => "/account_info/$id";

  static String path_account_create = "/account_create";
}
