import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yourchari_app/views/auth/create_profile_page.dart';
import 'package:yourchari_app/views/auth/login_page.dart';
import 'package:yourchari_app/views/main/home_screen.dart';
import 'package:yourchari_app/views/main/profile_screen.dart';

// import 'views/components/home_bottom_navigation_bar.dart';
// import 'models/home_bottom_navigation_bar_model.dart';
import 'viewModels/main_controller.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // MyAppが起動した最初の時にユーザーがログインしているかどうかの確認
    // この変数を1回きり
    final User? onceUser = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'yourchari',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.light,
          primarySwatch: Colors.blueGrey,
        ),
      ),
      // home: onceUser == null
      //     ? const LoginPage()
      //     : // ユーザーが存在していない
      //     onceUser.emailVerified
      //         ? const MyHomePage() // ユーザーは存在していて、メールアドレスが認証されている
      //         : const NewsScreen(), // ユーザーは存在しているが、メールアドレスが認証されていない
      home: onceUser == null
          ? const LoginPage()
          : // ユーザーが存在していない
          onceUser.emailVerified
              ? const MyHomePage()
              : const MyHomePage(),
      // home: NewsScreen(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainController mainController = ref.watch(mainProvider);
    PersistentTabController controller =
        PersistentTabController(initialIndex: 0);

    List<Widget> buildScreens() {
      return [
        const HomeScreen(),
        // const SearchScreen(),
        // const NewsScreen(),
        ProfileScreen(
          homeContext: context,
        ),
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
        // PersistentBottomNavBarItem(
        //     icon: const Icon(CupertinoIcons.search),
        //     title: ("Search"),
        //     activeColorPrimary: CupertinoColors.systemGrey
        //     // inactiveColorPrimary: CupertinoColors.systemGrey,
        //     ),
        // PersistentBottomNavBarItem(
        //     icon: const Icon(CupertinoIcons.news),
        //     title: ("News"),
        //     activeColorPrimary: CupertinoColors.systemGrey
        //     // inactiveColorPrimary: CupertinoColors.systemGrey,
        //     ),
        PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.profile_circled),
            title: ("Profile"),
            activeColorPrimary: CupertinoColors.systemGrey
            // inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
      ];
    }

    return mainController.isLoading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : !mainController.isFirestoreUserExist
            ? const CreateProfilePage()
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
                navBarStyle: NavBarStyle
                    .style6, // Choose the nav bar style with this property.
              );
  }
}
