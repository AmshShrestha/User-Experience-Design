import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_log/config/router/app_route.dart';

import '../viewmodel/auth_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginkey = GlobalKey<FormState>();

  bool isObsecure = true;

  var gap = const SizedBox(
    height: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginkey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your username',
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.blue,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    } else {
                      return null;
                    }
                  },
                ),
                gap,
                TextFormField(
                  controller: _passwordController,
                  obscureText: isObsecure,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter your Password',
                    icon: const Icon(Icons.lock, color: Colors.black),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObsecure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isObsecure = !isObsecure;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    } else {
                      return null;
                    }
                  },
                ),
                gap,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.black,
                  ),
                  key: const ValueKey('loginButton'),
                  onPressed: () async {
                    if (_loginkey.currentState!.validate()) {
                      await ref.read(authViewModelProvider.notifier).loginUser(
                            context,
                            _usernameController.text,
                            _passwordController.text,
                          );
                    }
                  },
                  child: const Text('Login'),
                ),
                gap,
                TextButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.registerRoute);
                  },
                  child: const Text('Create my account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
