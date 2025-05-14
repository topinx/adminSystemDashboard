import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_back/bean/bean_account_info.dart';
import 'package:top_back/bean/bean_image.dart';
import 'package:top_back/bean/bean_inter_cnt.dart';
import 'package:top_back/bean/bean_note.dart';
import 'package:top_back/util/utils.dart';

final userEditProvider = StateProvider<bool>((ref) => false);

class UserEditInfo {
  BeanImage avatar = BeanImage("", null);

  BeanImage cover = BeanImage("", null);

  int gender = 0;

  String birth = "";

  int create = 0;

  String phoneArea = "+1";

  /// 账号状态 0 停用 1 正常
  int state_a = 1;

  /// 认证状态 1 普通 2 博主 3 商户
  int state_v = 1;

  String get birthday => birth.isEmpty ? "未设置" : birth;

  int get age => Utils.getAge(birth);

  String get createDate => create == 0
      ? "0000-00-00 00:00:00"
      : DateTime.fromMillisecondsSinceEpoch(create).toString().substring(0, 19);

  UserEditInfo({
    BeanImage? avatar,
    BeanImage? cover,
    this.gender = 0,
    this.birth = "",
    this.create = 0,
    this.phoneArea = "+1",
    this.state_a = 1,
    this.state_v = 1,
  })  : this.avatar = avatar ?? BeanImage("", null),
        this.cover = avatar ?? BeanImage("", null);

  UserEditInfo copyWith({
    BeanImage? avatar,
    BeanImage? cover,
    int? gender,
    String? birth,
    int? create,
    String? phoneArea,
    int? state_a,
    int? state_v,
  }) {
    return UserEditInfo(
      avatar: avatar ?? this.avatar,
      cover: cover ?? this.cover,
      gender: gender ?? this.gender,
      birth: birth ?? this.birth,
      create: create ?? this.create,
      phoneArea: phoneArea ?? this.phoneArea,
      state_a: state_a ?? this.state_a,
      state_v: state_v ?? this.state_v,
    );
  }
}

class UserEditInfoProvider extends StateNotifier<UserEditInfo> {
  UserEditInfoProvider() : super(UserEditInfo());

  void updateAvatar(BeanImage image) {
    state = state.copyWith(avatar: image);
  }

  void updateCover(BeanImage image) {
    state = state.copyWith(cover: image);
  }

  void updateBirth(String date) {
    state = state.copyWith(birth: date);
  }

  void updateWithUserInfo(BeanAccountInfo bean) {
    state = state.copyWith(
      avatar: BeanImage(bean.avatar, null),
      cover: BeanImage(bean.bgImg, null),
      gender: bean.gender,
      birth: bean.birthday,
      create: bean.createTime,
      phoneArea: bean.areaCode,
      state_a: bean.status,
      state_v: bean.authenticationStatus,
    );
  }
}

final userInfoProvider =
    StateNotifierProvider<UserEditInfoProvider, UserEditInfo>(
  (ref) => UserEditInfoProvider(),
);

final userInterProvider = StateProvider<BeanInterCnt>((ref) => BeanInterCnt());

class UserNoteInfo {
  int count = 0;
  BeanNote note = BeanNote();
}

final userNoteProvider = StateProvider<UserNoteInfo>((ref) => UserNoteInfo());
