class HttpConstants {
  /// 注册账号
  static const register = "/adminsystem/user/register";

  /// 登录
  static const login = "/adminsystem/user/login";

  /// 菜单列表
  static const menuList = "/adminsystem/system/getResource";

  /// token刷新
  static const refreshToken = "/adminsystem/user/refreshToken";

  /// 上传
  static const upload = "/adminsystem/system/file/upload";

  /// 上传视频
  static const uploadVideo = "/adminsystem/system/file/uploadVideo";

  /// 签名
  static const sign = "/adminsystem/system/file/getSignUrl";

  /// 创建应用账号
  static const createAccount = "/adminsystem/accountManagement/createAccount";

  /// 账号列表
  static const accountList = "/adminsystem/accountManagement/getUserList";

  /// 账号数
  static const accountCnt = "/adminsystem/accountManagement/countUser";

  /// 批量修改账号状态
  static const modifyStatus =
      "/adminsystem/accountManagement/batchUpdateStatus";

  /// 查询账号详情
  static const accountInfo = "/adminsystem/accountManagement/getUserDetail";

  /// 查询用户互动数据
  static const interactiveCnt = "/adminsystem/accountManagement/homePageCnt";

  /// 编辑用户信息
  static const editAccount = "/adminsystem/accountManagement/updateInfo";

  /// 重置密码
  static const resetPassword = "/adminsystem/accountManagement/resetPwd";

  /// 重置用户信息
  static const resetAccount = "/adminsystem/accountManagement/resetInfo";

  /// 查询笔记列表
  static const noteList = "/adminsystem/contentManagement/getNoteList";

  /// 查询笔记总数
  static const noteCnt = "/adminsystem/contentManagement/countAuditNote";

  /// 话题列表
  static const topicList = "/adminsystem/contentManagement/getTopicList";

  /// 话题总数
  static const topicCnt = "/adminsystem/contentManagement/countTopic";

  /// 创建话题
  static const topicCreate = "/adminsystem/contentManagement/createTopic";

  /// 编辑话题
  static const topicEdit = "/adminsystem/contentManagement/updateTopic";

  /// 编辑话题状态
  static const topicStatus = "/adminsystem/contentManagement/updateTopicStatus";

  /// 删除话题
  static const topicDelete = "/adminsystem/contentManagement/deleteTopic";

  /// 后台账号下的笔记列表
  static const noteListBack =
      "/adminsystem/contentManagement/getNoteListByUserId";

  /// 后台账号下的笔记总数
  static const noteCntBack =
      "/adminsystem/contentManagement/countAuditNoteByUserId";

  /// 笔记详情
  static const noteDetail = "/adminsystem/contentManagement/getNoteDetail";

  /// 昵称搜索系统用户
  static const searchUser = "/adminsystem/user/searchSysUser";

  /// 获取一条待审核的笔记
  static const nextAuditedNote =
      "/adminsystem/contentManagement/getNextUnAuditedNote";

  /// 审核笔记
  static const checkNote = "/adminsystem/contentManagement/auditNote";

  /// 发布笔记
  static const publish = "/adminsystem/contentManagement/publishNote";

  /// 更新笔记
  static const updateNote = "/adminsystem/contentManagement/updateNote";

  /// 昵称搜索app账号
  static const searchAppUser = "/adminsystem/user/searchAppUser";
}
