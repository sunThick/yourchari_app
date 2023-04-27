// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:yourchari_app/app.dart';

// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   String newUserUsername = "";
//   String newUserEmail = "";
//   String newUserPassword = "";

//   // Future<void> createUser(uid) async {
//   //   final usersCollection = FirebaseFirestore.instance.collection('users');
//   //   await usersCollection
//   //       .doc(uid)
//   //       .set({'username': newUserUsername, 'createdDate': Timestamp.now()});
//   //   print(uid);
//   // }

//   // ユーザー情報を登録する関数を定義
//   Future<void> createAuth() async {
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     UserCredential result = await auth.createUserWithEmailAndPassword(
//       email: newUserEmail,
//       password: newUserPassword,
//     );
//     // 上のFirebaseAuthから、uidを取得する変数を定義
//     final user = result.user;
//     final uuid = user?.uid;
//     // usersコレクションを作成して、uidとドキュメントidを一致させるプログラムを定義
//     FirebaseFirestore.instance.collection('users').doc(uuid).set({
//       'uid': uuid,
//       'username': newUserUsername,
//       'email': newUserEmail,
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width * 0.85,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/homeLogo.png',
//                 fit: BoxFit.contain,
//                 height: 35,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               const CircleAvatar(
//                 radius: 30,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   radius: 38.0,
//                   backgroundImage: NetworkImage(
//                       'https://images.unsplash.com/photo-1658033014478-cc3b36e31a5e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMDR8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 12.0,
//                       child: Icon(
//                         Icons.camera_alt,
//                         size: 15.0,
//                         color: Color(0xFF404040),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: TextFormField(
//                   onChanged: (value) {
//                     newUserUsername = value;
//                   },
//                   decoration: const InputDecoration(
//                     labelText: "username",
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: TextFormField(
//                   onChanged: (value) {
//                     newUserEmail = value;
//                   },
//                   decoration: const InputDecoration(labelText: "email"),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: TextFormField(
//                   onChanged: (value) {
//                     newUserPassword = value;
//                   },
//                   obscureText: true,
//                   decoration: const InputDecoration(labelText: "password"),
//                 ),
//               ),
//               ElevatedButton(
//                 child: const Text('新規登録'),
//                 onPressed: () async {
//                   try {
//                     await createAuth();
//                     Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const MyStatefulWidget()));
//                   } on FirebaseAuthException catch (e) {
//                     if (e.code == 'email-already-in-use') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('指定したメールアドレスは登録済みです'),
//                         ),
//                       );
//                     } else if (e.code == 'invalid-email') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('メールアドレスのフォーマットが正しくありません'),
//                         ),
//                       );
//                     } else if (e.code == 'operation-not-allowed') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('指定したメールアドレス・パスワードは現在使用できません'),
//                         ),
//                       );
//                     } else if (e.code == 'weak-password') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('パスワードは６文字以上にしてください'),
//                         ),
//                       );
//                     }
//                   }
//                 },
//               ),
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('ユーザー登録済みの方はこちら'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
