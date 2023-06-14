// flutter
import 'package:flutter/material.dart';
// package
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  timeAgo.setLocaleMessages("ja", timeAgo.JaMessages());
  runApp(const ProviderScope(child: MyApp()));
}
