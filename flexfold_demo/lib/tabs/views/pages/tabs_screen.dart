import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../navigation/constants/app_routes.dart';
// import 'package:routemaster/routemaster.dart';

import '../../../settings/controllers/pods_flexfold.dart';
import '../widgets/tab_app_bar.dart';
import 'tab_guide.dart';
import 'tab_images.dart';
import 'tab_modal.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  static const String route = AppRoutes.tabs;

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1,
    );
    _controller.addListener(() {
      if (!_controller.indexIsChanging) {
        // If we are changing the tab bar item, we will reveal any
        // scroll hidden bottom navigation bar
        ref.read(scrollHiddenBottomBarPod.notifier).state = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // @override
  // void didUpdateWidget(FamilyTabsPage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   _controller.index = widget.index;
  // }

  @override
  Widget build(BuildContext context) {
    // return
    // Consumer(
    //   builder: (BuildContext context, WidgetRef ref, Widget? child) {
    // See setup_screen.dart [ConfigScreen] for an explanation of these
    // padding values and why they are VERY handy and useful.
    final double topPadding = MediaQuery.of(context).padding.top;

    // final TabPageState tabPage = TabPage.of(context);
    // tabPage.addListener(() {
    //   if (!tabPage.controller.indexIsChanging) {
    //     // If we are changing the tab bar item, we will reveal any
    //     // scroll hidden bottom navigation bar
    //     ref.read(scrollHiddenBottomBarPod.state).state = false;
    //   }
    // });
    // TODO(rydmike): Routemaster commented This was in body
    // DefaultTabController(
    //   length: 4,
    //   child: Builder(
    //     builder: (BuildContext context) {
    //       final TabController tabController =
    //           DefaultTabController.of(context)!;
    //       tabController.addListener(() {
    //         if (!tabController.indexIsChanging) {
    //           // If we are changing the tab bar item, we will reveal any
    //           // scroll hidden bottom navigation bar
    //           appOptions.setScrollHiddenBottomBar(false);
    //         }
    //       });
    //
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TabBar(
            // key: const ValueKey<String>(route),
            // key: const PageStorageKey<String>(route),
            controller: _controller,
            tabs: <Widget>[
              Tab(text: AppRoutes.tabsGuideLabel.toUpperCase()),
              Tab(text: AppRoutes.tabsAppbarLabel.toUpperCase()),
              Tab(text: AppRoutes.tabsImagesLabel.toUpperCase()),
              Tab(text: AppRoutes.tabsModalLabel.toUpperCase()),
            ],
            onTap: (int index) {
              // If we tapped on a tab bar item, we will reveal any
              // scroll hidden bottom navigation bar
              ref.read(scrollHiddenBottomBarPod.notifier).state = false;
              _controller.index = index;
              // if (index == 0) context.goNamed(AppRoutes.tabsGuideLabel);
              // if (index == 1) context.goNamed(AppRoutes.tabsAppbarLabel);
              // if (index == 2) context.goNamed(AppRoutes.tabsImagesLabel);
              // if (index == 3) context.goNamed(AppRoutes.tabsModalLabel);
            },
          ),
          const Divider(
            height: 0,
            thickness: 0,
          ),
          Flexible(
            child: TabBarView(
              // key: const ValueKey<String>(route),
              // key: const PageStorageKey<String>(route),
              controller: _controller,
              dragStartBehavior: DragStartBehavior.start,
              children: const <Widget>[
                TabGuide(),
                TabAppBar(),
                TabImages(),
                TabModal(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
