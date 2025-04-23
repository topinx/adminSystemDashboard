import 'package:top_back/pages/page_admin/provider/menu_provider.dart';
import 'package:top_back/router/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdminDrawer extends ConsumerWidget {
  Widget buildDrawerList(List<Menu> menuList) {
    return ListView.builder(
      itemCount: menuList.length,
      padding: EdgeInsets.zero,
      itemBuilder: (_, i) => MenuItem(menuList[i]),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuAsync = ref.watch(fetchMenuListProvider);

    return Container(
      width: 230,
      color: Theme.of(context).canvasColor,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 80),
      child: menuAsync.when(
        data: buildDrawerList,
        loading: () => const AdminDrawerLoading(),
        error: (_, __) => const SizedBox(),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem(this.menu, {super.key});

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(menu.text),
      leading: Icon(menu.icon),
      initiallyExpanded: false,
      shape: Border(),
      children: List.generate(
        menu.children.length,
        (index) => ListTile(
            leading: const SizedBox(),
            onTap: () => context.go(menu.children[index].route),
            title: Text(menu.children[index].text)),
      ),
    );
  }
}

class AdminDrawerLoading extends StatelessWidget {
  const AdminDrawerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RepaintBoundary(
        child: CupertinoActivityIndicator(color: Colors.white),
      ),
    );
  }
}
