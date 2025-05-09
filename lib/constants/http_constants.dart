class HttpConstant {
  /// 登录
  static const login = "/adminsystem/user/login";

  /// token刷新
  static const refreshToken = "/adminsystem/user/refreshToken";

  /// 菜单列表
  static const menuList = "/adminsystem/system/getResource";

  /// 账号列表
  static const accountList = "/adminsystem/accountManagement/getUserList";

  /// 账号数
  static const accountCnt = "/adminsystem/accountManagement/countUser";

  /// 批量修改账号状态
  static const modifyStatus =
      "/adminsystem/accountManagement/batchUpdateStatus";

  /// 查询笔记列表
  static const noteList = "/adminsystem/contentManagement/getNoteList";

  /// 查询笔记总数
  static const noteCnt = "/adminsystem/contentManagement/countAuditNote";

  /// 话题列表
  static const topicList = "/adminsystem/contentManagement/getTopicList";

  /// 话题总数
  static const topicCnt = "/adminsystem/contentManagement/countTopic";

  /// 笔记详情
  static const noteInfo = "/adminsystem/contentManagement/getNoteDetail";

  /// 更新笔记
  static const editNote = "/adminsystem/contentManagement/updateNote";
}
