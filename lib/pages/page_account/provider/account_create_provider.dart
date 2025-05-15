import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_back/bean/bean_image.dart';

class UserCreateInfo {
  BeanImage avatar = BeanImage("", null);

  BeanImage cover = BeanImage("", null);

  int gender = 0;

  UserCreateInfo({
    BeanImage? avatar,
    BeanImage? cover,
    this.gender = 0,
  })  : this.avatar = avatar ?? BeanImage("", null),
        this.cover = avatar ?? BeanImage("", null);

  UserCreateInfo copyWith({
    BeanImage? avatar,
    BeanImage? cover,
    int? gender,
  }) {
    return UserCreateInfo(
      avatar: avatar ?? this.avatar,
      cover: cover ?? this.cover,
      gender: gender ?? this.gender,
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
}

final userCreateProvider =
    StateNotifierProvider<UserCreateProvider, UserCreateInfo>(
  (ref) => UserCreateProvider(),
);
