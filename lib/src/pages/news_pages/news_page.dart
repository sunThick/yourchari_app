// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../../auth_pages/login_page.dart';

// class NewsScreen extends StatelessWidget {
//   const NewsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('news'),
//         actions: [
//           IconButton(
//             //ステップ２
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               if (FirebaseAuth.instance.currentUser == null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('ログアウトしました'),
//                   ),
//                 );
//               }
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => const UserLogin()));
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body:
//           const Center(child: Text('news画面', style: TextStyle(fontSize: 32.0))),
//     );
//   }
// }
