import 'package:top_back/bean/bean_menu.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/extension/extension.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/router/menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_provider.g.dart';

@riverpod
Future<List<Menu>> fetchMenuList(Ref ref) async {
  var response = await DioRequest().request(HttpConstant.menuList);
  return decodeMenuList(response);
}

List<Menu> decodeMenuList(response) {
  List<Menu> menuList = [];

  for (var temp in response ?? []) {
    BeanMenu bean = BeanMenu.fromJson(temp);
    if (routeMap[bean.resourceId] == null) continue;
    // if (!Storage().user.resourceList.contains(bean.resourceId)) {
    //   continue;
    // }

    if (bean.parentId == 0) {
      menuList.add(routeMap[bean.resourceId]!);
    } else {
      if (routeMap[bean.parentId] == null) continue;
      Menu? parent = menuList.firstWhereOrNull((x) => x.id == bean.parentId);
      if (parent == null) {
        parent = routeMap[bean.parentId]!;
        menuList.add(parent);
      }
      parent.children.add(routeMap[bean.resourceId]!);
    }
  }

  return menuList;
}
