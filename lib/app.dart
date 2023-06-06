import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yourchari_app/views/auth/login_page.dart';
import 'package:yourchari_app/views/main/home_screen.dart';
import 'package:yourchari_app/views/main/profile_screen.dart';
import 'package:yourchari_app/views/main/news_screen.dart';
import 'package:yourchari_app/views/main/search_screen.dart';

// import 'views/components/home_bottom_navigation_bar.dart';
// import 'models/home_bottom_navigation_bar_model.dart';
import 'models/main_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MyAppが起動した最初の時にユーザーがログインしているかどうかの確認
    // この変数を1回きり
    final User? onceUser = FirebaseAuth.instance.currentUser;

    // print(onceUser);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'yourchari',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: onceUser == null ? const LoginPage() : const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainModel mainModel = ref.watch(mainProvider);
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);

    List<Widget> buildScreens() {
      return [
        const HomeScreen(),
        const SearchScreen(),
        const NewsScreen(),
        const ProfileScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.systemGrey,
          // inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.search),
            title: ("Search"),
            activeColorPrimary: CupertinoColors.systemGrey
            // inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
        PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.news),
            title: ("News"),
            activeColorPrimary: CupertinoColors.systemGrey
            // inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
        PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.profile_circled),
            title: ("Profile"),
            activeColorPrimary: CupertinoColors.systemGrey
            // inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
      ];
    }

    return mainModel.isLoading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : PersistentTabView(
            context,
            controller: controller,
            screens: buildScreens(),
            items: navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.white, // Default is Colors.white.
            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset:
                true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true, // Default is true.
            hideNavigationBarWhenKeyboardShows:
                true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 20),
              curve: Curves.ease,
            ),
            // screenTransitionAnimation: const ScreenTransitionAnimation(
            //   // Screen transition animation on change of selected tab.
            //   animateTabTransition: true,
            //   curve: Curves.ease,
            //   duration: Duration(milliseconds: 200),
            // ),
            navBarStyle: NavBarStyle
                .style6, // Choose the nav bar style with this property.
          );
  }
  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   final MainModel mainModel = ref.watch(mainProvider);
  //   final HomeBottomNavigationBarModel homeBottomNavigationBarModel =
  //       ref.watch(homeBottomNavigationBarProvider);

  //   const List<Widget> screens = [
  //     HomeScreen(),
  //     SearchScreen(),
  //     NewsScreen(),
  //     ProfileScreen(),
  //   ];
  //   return Scaffold(
  //     body: mainModel.isLoading
  //         ? const Center(
  //             child: Text('loading'),
  //           )
  //         : screens[homeBottomNavigationBarModel.currentIndex],
  //     bottomNavigationBar: SafeArea(
  //       child: HomeBottomNavigationBar(
  //           homeBottomNavigationBarModel: homeBottomNavigationBarModel),
  //     ),
  //   );
  // }
}
