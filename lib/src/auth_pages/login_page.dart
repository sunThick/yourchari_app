// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:yourchari_app/app.dart';
// import 'package:yourchari_app/src/auth_pages/signup_page.dart';

// class UserLogin extends StatefulWidget {
//   const UserLogin({Key? key}) : super(key: key);

//   @override
//   State<UserLogin> createState() => _UserLogin();
// }

// class _UserLogin extends State<UserLogin> {
//   final _auth = FirebaseAuth.instance;

//   String email = '';
//   String password = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Image.asset(
//       //     'assets/images/homeLogo.png',
//       //     fit: BoxFit.contain,
//       //     height: 35,
//       //   ),
//       // ),
//       body: Center(
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width * 0.85,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/homeLogo.png',
//                 fit: BoxFit.contain,
//                 height: 50,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: TextField(
//                   onChanged: (value) {
//                     email = value;
//                   },
//                   decoration: const InputDecoration(labelText: "Email"),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: TextField(
//                   onChanged: (value) {
//                     password = value;
//                   },
//                   obscureText: true,
//                   decoration: const InputDecoration(labelText: "Password"),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                 child: const Text('ログイン'),
//                 onPressed: () async {
//                   try {
//                     await _auth.signInWithEmailAndPassword(
//                         email: email, password: password);
//                     Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const MyStatefulWidget()));
//                   } on FirebaseAuthException catch (e) {
//                     if (e.code == 'invalid-email') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('メールアドレスのフォーマットが正しくありません'),
//                         ),
//                       );
//                     } else if (e.code == 'invalid-email') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('メールアドレスのフォーマットが正しくありません'),
//                         ),
//                       );
//                     } else if (e.code == 'user-disabled') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('現在指定したメールアドレスは使用できません'),
//                         ),
//                       );
//                     } else if (e.code == 'user-not-found') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('指定したメールアドレスは登録されていません'),
//                         ),
//                       );
//                     } else if (e.code == 'wrong-password') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('パスワードが間違っています'),
//                         ),
//                       );
//                     }
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const Register()));
//                   },
//                   child: const Text('初めての方はこちら')),
//               TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const Register()));
//                   },
//                   child: const Text('passwordをお忘れですか？'))
//             ],
//           ),
//         ),a
//       ),
//     );
//   }
// }
