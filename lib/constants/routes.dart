import 'package:flutter/material.dart';

import '../models/main_model.dart';
import '../app.dart';
import '../views/auth/login_page.dart';
import '../views/auth/signup_page.dart';

void toMyApp({required BuildContext context}) => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));

void toSignupPage({required BuildContext context}) => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
 
void toLoginPage({required BuildContext context,required MainModel mainModel}) => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));