// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/routes.dart';

import '../../viewModels/auth/signup_controller.dart';
// models

class SignupPage extends ConsumerWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupController signupController = ref.watch(signupNotifierProvider);

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/homeLogo.png',
                fit: BoxFit.contain,
                height: 35,
              ),
              const SizedBox(
                height: 30,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     keyboardType: TextInputType.emailAddress,
              //     // controller: signupController.userNameEditingController,
              //     decoration: const InputDecoration(labelText: "username"),

              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: signupController.emailEditingController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: signupController.passwordEditingController,
                  obscureText: signupController.isObscure,
                  decoration: InputDecoration(
                      labelText: "password",
                      suffix: InkWell(
                        child: const Icon(Icons.visibility_off),
                        onTap: () => signupController.toggleIsObscure(),
                      )),
                ),
              ),
              ElevatedButton(
                onPressed: () => signupController.createUser(context: context),
                child: const Text('新規登録'),
              ),
              TextButton(
                  onPressed: () {
                    toLoginPage(context: context);
                  },
                  child: const Text('ユーザー登録済みの方はこちら')),
            ],
          ),
        ),
      ),
    );
  }
}
