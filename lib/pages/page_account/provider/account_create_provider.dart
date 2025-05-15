import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_back/bean/bean_image.dart';

class UserCreateInfo {
  BeanImage avatar = BeanImage("", null);

  BeanImage cover = BeanImage("", null);

  int gender = 0;

  String birth = "";

  String phoneArea = "+1";

  String get birthday => birth.isEmpty ? "设置日期" : birth;

  void removeImgMemory() {
    avatar = BeanImage("", null);
    cover = BeanImage("", null);
  }

  UserCreateInfo({
    BeanImage? avatar,
    BeanImage? cover,
    this.gender = 0,
    this.birth = "",
    this.phoneArea = "+1",
  })  : this.avatar = avatar ?? BeanImage("", null),
        this.cover = avatar ?? BeanImage("", null);

  UserCreateInfo copyWith({
    BeanImage? avatar,
    BeanImage? cover,
    int? gender,
    String? birth,
    String? phoneArea,
  }) {
    return UserCreateInfo(
      avatar: avatar ?? this.avatar,
      cover: cover ?? this.cover,
      gender: gender ?? this.gender,
      birth: birth ?? this.birth,
      phoneArea: phoneArea ?? this.phoneArea,
    );
  }
}

class UserCreateProvider extends StateNotifier<UserCreateInfo> {
  UserCreateProvider() : super(UserCreateInfo());

  void updateAvatar(BeanImage image) {
    state = state.copyWith(avatar: image);
  }

  void updateCover(BeanImage image) {
    state = state.copyWith(cover: image);
  }

  void updateBirth(String date) {
    state = state.copyWith(birth: date);
  }
}

final userCreateProvider =
    StateNotifierProvider<UserCreateProvider, UserCreateInfo>(
  (ref) => UserCreateProvider(),
);
