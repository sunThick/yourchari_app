import 'package:flutter/material.dart';
import 'package:yourchari_app/domain/chari/chari.dart';
import 'package:yourchari_app/domain/firestore_user/firestore_user.dart';
import 'package:yourchari_app/views/form/create_chari_page.dart';
import 'package:yourchari_app/views/passive_user_profile_page.dart';

import '../models/main_model.dart';
import '../app.dart';
import '../views/auth/login_page.dart';
import '../views/auth/signup_page.dart';
import '../views/detail_chari_page.dart';

void toMyApp({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const MyApp()));

void toCreateChariPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const CreateChariPage()));

void toSignupPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const SignupPage()));

void toLoginPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));

void toChariDetailPage({required BuildContext context, required String chariUid}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChariDetailPage(chariUid: chariUid,
                )));

void toPassiveUserPage({required BuildContext context, required String userId}) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => PassiveUserProfilePage(userId: userId,)));


