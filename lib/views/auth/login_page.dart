import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewModels/auth/login_controller.dart';
import '/constants/routes.dart' as routes;

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginController loginController = ref.watch(loginNotifierProvider);
    //formcontroller
    final TextEditingController emailEditingController =
        TextEditingController(text: loginController.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: loginController.password);
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
                height: 50,
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailEditingController,
                  onChanged: (text) => loginController.email = text,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordEditingController,
                  onChanged: (text) => loginController.password = text,
                  obscureText: loginController.isObscure,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffix: InkWell(
                      child: loginController.isObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onTap: () => loginController.toggleIsObscure(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => loginController.login(context: context),
                child: const Text('ログイン'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    routes.toSignupPage(context: context);
                  },
                  child: const Text('初めての方はこちら')),
            ],
          ),
        ),
      ),
    );
  }
}
