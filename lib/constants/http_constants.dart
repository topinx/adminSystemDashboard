class HttpConstant {
  /// 登录
  static const login = "/adminsystem/user/login";

  /// token刷新
  static const refreshToken = "/adminsystem/user/refreshToken";

  /// 预签名
  static const signMedia = "/adminsystem/system/file/presigner";

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

  /// 查询账号详情
  static const accountInfo = "/adminsystem/accountManagement/getUserDetail";

  /// 编辑用户信息
  static const editAccount = "/adminsystem/accountManagement/updateInfo";

  /// 重置密码
  static const resetPassword = "/adminsystem/accountManagement/resetPwd";

  /// 重置用户信息
  static const resetAccount = "/adminsystem/accountManagement/resetInfo";

  /// 查询用户互动数据
  static const interactiveCnt = "/adminsystem/accountManagement/homePageCnt";

  /// 创建应用账号
  static const createAccount = "/adminsystem/accountManagement/createAccount";

  /// 编辑话题状态
  static const topicStatus = "/adminsystem/contentManagement/updateTopicStatus";

  /// 删除话题
  static const topicDelete = "/adminsystem/contentManagement/deleteTopic";

  /// 创建话题
  static const topicCreate = "/adminsystem/contentManagement/createTopic";

  /// 编辑话题
  static const topicEdit = "/adminsystem/contentManagement/updateTopic";
}
