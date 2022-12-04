// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utility/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose(); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 5, 10, 5),
            color: const Color.fromRGBO(235, 232, 232, 0.91),
            child: TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'example@email.com',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 5, 10, 5),
            color: const Color.fromRGBO(235, 232, 232, 0.91),
            child: TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: '********',
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final usercredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                log(usercredential.toString());
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  if (user.emailVerified) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/main_ui/', (_) => false);
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/email_verification/', (_) => false);
                  }
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'wrong-password') {
                  await showErrorDialog(context, 'Wrong username or password');
                } else if (e.code == 'invalid-email') {
                  await showErrorDialog(context, 'Invalid email');
                } else if (e.code == 'user-not-found') {
                  await showErrorDialog(context, 'User not found');
                } else {
                  String s = e.code;
                  for (int i = 0; i < s.length; i++) {
                    if (s[i] == '-') {
                      s = replaceCharAt(s, i, ' ');
                    }
                  }
                  await showErrorDialog(context, 'Error: $s');
                }
                //print(e.code);
              } catch (e) {
                String s = e.toString();
                for (int i = 0; i < s.length; i++) {
                  if (s[i] == '-') {
                    s = replaceCharAt(s, i, ' ');
                  }
                }
                await showErrorDialog(context, 'Error: $s');
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/register/', (route) => false);
            },
            child: const Text("Not registered yet? Rgister now."),
          ),
        ],
      ),
    );
  }
}
