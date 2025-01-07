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
}
