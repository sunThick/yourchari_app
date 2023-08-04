import 'package:flutter/material.dart';
import 'package:yourchari_app/viewModels/auth/account_controller.dart';
import 'package:yourchari_app/views/auth/account_page.dart';
import 'package:yourchari_app/views/auth/create_profile_page.dart';
import 'package:yourchari_app/views/auth/delete_user_page.dart';
import 'package:yourchari_app/views/complete_inquiry_page.dart';
import 'package:yourchari_app/views/edit_profile_page.dart';
import 'package:yourchari_app/views/finish_page.dart';
import 'package:yourchari_app/views/form/create_chari_page.dart';
import 'package:yourchari_app/views/form/inquiry_page.dart';
import 'package:yourchari_app/views/like_chari_list_page.dart';
import 'package:yourchari_app/views/mute_users_page.dart';
import 'package:yourchari_app/views/passive_user_profile_page.dart';
import 'package:yourchari_app/views/terms_of_use_page.dart';

import '../app.dart';
import '../viewModels/auth/reauthentication_page.dart';
import '../views/auth/login_page.dart';
import '../views/auth/signup_page.dart';
import '../views/auth/update_email_page.dart';
import '../views/auth/update_password_page.dart';
import '../views/auth/verify_password_reset_page.dart';
import '../views/detail_chari_page.dart';
import '../views/follows_and_followers_page.dart';

void toMyApp({required BuildContext context}) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => const MyApp()));

void toCreateChariPage({required BuildContext context}) =>
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => const CreateChariPage()));

void toCreateProfilePage({required BuildContext context}) =>
    Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => const CreateProfilePage()));

void toSignupPage({required BuildContext context}) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => const SignupPage()));

void toLoginPage({
  required BuildContext context,
}) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));

void toChariDetailPage(
        {required BuildContext context, required String chariUid}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChariDetailPage(
            chariUid: chariUid,
          ),
        ));

void toFollowsAndFollowersPage(
        {required BuildContext context,
        required String userUid,
        required String followingOrFollowers}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FollowsAndFollowersPage(
                  userUid: userUid,
                  followingOrFollowers: followingOrFollowers,
                )));

void toPassiveUserPage(
        {required BuildContext context, required String userId}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PassiveUserProfilePage(
                  userId: userId,
                )));

void toMuteUsersPage({required BuildContext context, required String uid}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MuteUsersPage(
                  uid: uid,
                )));

void toLikechariListPage(
        {required BuildContext context, required String uid}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LikeChariListPage(
                  uid: uid,
                )));

// void toEditProfilePage({required BuildContext context, rootNavigator = true}) =>
//     Navigator.push(context,
//         MaterialPageRoute(builder: (context) => const EditProfilePage()));

void toEditProfilePage({required BuildContext context}) =>
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => const EditProfilePage()));

void toReauthenticationPage(
        {required BuildContext context,
        required AccountController accountController,
        required BuildContext homeContext}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => ReauthenticationPage(
                  accountController: accountController,
                  homeContext: homeContext,
                ))));

void toUpdatePasswordPage({required BuildContext context}) => Navigator.push(
    context,
    MaterialPageRoute(builder: ((context) => const UpdatePasswordPage())));

void toAccountPage(
        {required BuildContext context, required BuildContext homeContext}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => AccountPage(homeContext: homeContext))));

void toUpdateEmailPage({required BuildContext context}) => Navigator.push(
    context,
    MaterialPageRoute(builder: ((context) => const UpdateEmailPage())));

void toDeleteUserPage(
        {required BuildContext context, required BuildContext homeContext}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => DeleteUserPage(
                  homeContext: homeContext,
                ))));

void toVerifyPasswordResetPage({required BuildContext context}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => const VerifyPasswordResetPage())));

void toFinishedage({required BuildContext context, required String msg}) =>
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(
        builder: ((context) => FinishedPage(
              msg: msg,
            ))));

void toTermsOfUserPage({required BuildContext context}) => Navigator.push(
    context,
    MaterialPageRoute(builder: ((context) => const TermsOfUserPage())));

void toInquiryPage({required BuildContext context}) => Navigator.push(
    context,
    MaterialPageRoute(builder: ((context) => const InquiryPage())));

void toCompleteInquiryPage({required BuildContext context, required String content}) => Navigator.push(
    context,
    MaterialPageRoute(builder: ((context) =>  CompleteInquilyPage(content: content,))));