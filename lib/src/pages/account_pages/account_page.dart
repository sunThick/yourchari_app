import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        } else if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        } else if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return profileScreen(data);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingScreen();
        } else {
          return const Text("Something went wrong");
        }
      },
    );
  }

  Widget profileScreen(data) {
    return Scaffold(
      appBar: AppBar(title: Text(data['username'])),
    );
  }

  Widget waitingScreen() {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
