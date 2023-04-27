// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/signup_model.dart';
// models

class SignupPage extends ConsumerWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupModel signupModel = ref.watch(signupProvider);
    final TextEditingController emailEditingController =
        TextEditingController(text: signupModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: signupModel.password);
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailEditingController,
                  onChanged: (text) => signupModel.email = text,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordEditingController,
                  onChanged: (text) => signupModel.password = text,
                  obscureText: signupModel.isObscure,
                  decoration: InputDecoration(
                      labelText: "password",
                      suffix: InkWell(
                        child: const Icon(Icons.visibility_off),
                        onTap: () => signupModel.toggleIsObscure(),
                      )),
                ),
              ),
              ElevatedButton(
                onPressed: () => signupModel.createUser(context: context),
                child: const Text('新規登録'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ユーザー登録済みの方はこちら')),
            ],
          ),
        ),
      ),
    );
  }
}
