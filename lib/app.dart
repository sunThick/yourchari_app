import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/views/auth/login_page.dart';
import 'package:yourchari_app/views/main/home_screen.dart';
import 'package:yourchari_app/views/main/profile_screen.dart';
import 'package:yourchari_app/views/main/search_screen.dart';

import 'details/home_bottom_navigation_bar.dart';
import 'models/home_bottom_navigation_bar_model.dart';
import 'models/main_model.dart';
import 'models/login_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MyAppが起動した最初の時にユーザーがログインしているかどうかの確認
    // この変数を1回きり
    final User? onceUser = FirebaseAuth.instance.currentUser;

    print(onceUser);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'yourchari',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
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
    final LoginModel loginModel = ref.watch(loginProvider);
    final HomeBottomNavigationBarModel homeBottomNavigationBarModel =
        ref.watch(homeBottomNavigationBarProvider);
    List<Widget> _screens = [
      FloatingActionButton(
        onPressed: () => loginModel.logout(context: context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      const HomeScreen(),
      const SearchScreen(),
      ProfileScreen(
        mainModel: mainModel,
        userImageURL: '',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('yourchari'),
      ),
      body: mainModel.isLoading
          ? const Center(
              child: Text('loading'),
            )
          : _screens[homeBottomNavigationBarModel.currentIndex],
      bottomNavigationBar: HomeBottomNavigationBar(
          homeBottomNavigationBarModel: homeBottomNavigationBarModel),
    );
  }
}
