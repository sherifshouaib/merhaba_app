import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/bottom_navbar_view_provider.dart';
import 'package:merhaba/features/home/presentation/views/home_tab_view.dart';
import 'package:merhaba/features/profile/presentation/views/profile_tab_view.dart';
import 'package:merhaba/features/tabs/presentation/views/friends_tab_view.dart';
import 'package:merhaba/features/tabs/presentation/views/notifications_tab_view.dart';
import 'package:merhaba/features/tabs/presentation/views/videos_tab_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavBarViewBody extends StatelessWidget {
  const BottomNavBarViewBody({
    super.key,
    required PersistentTabController controller,
    required this.bottomNavBarViewProvider,
  }) : _controller = controller;

  final PersistentTabController _controller;
  final BottomNavBarViewProvider bottomNavBarViewProvider;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: [
        HomeTabView(),
        FriendsTabView(),
        VideosTabView(),
        NotificationsTabView(),
        ProfileTabView(),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.group),
          title: ("Friends"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.video_camera_solid),
          title: ("Videos"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.notifications),
          title: ("Notifications"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle_sharp),
          title: ("Profile"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ],
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Colors.grey.shade900,
      isVisible: bottomNavBarViewProvider.isVisible,
      // animationSettings: const NavBarAnimationSettings(
      //   navBarItemAnimation: ItemAnimationSettings(
      //     // Navigation Bar's items animation properties.
      //     duration: Duration(milliseconds: 100),
      //     curve: Curves.ease,
      //   ),
      //   screenTransitionAnimation: ScreenTransitionAnimationSettings(
      //     // Screen transition animation on change of selected tab.
      //     animateTabTransition: true,
      //     duration: Duration(milliseconds: 100),
      //     screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
      //   ),
      // ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle:
          NavBarStyle.style14, // Choose the nav bar style with this property
    );
  }
}
