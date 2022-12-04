import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/utility/show_error_dialog.dart';

class RegesterView extends StatefulWidget {
  const RegesterView({super.key});

  @override
  State<RegesterView> createState() => _RegesterViewState();
}

class _RegesterViewState extends State<RegesterView> {
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
        title: const Text('Register'),
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
                hintText: 'password',
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                log('reg sucess');
                Navigator.of(context).pushNamed('/email_verification/');
              } on FirebaseAuthException catch (e) {
                if (e.code == 'invalid-email') {
                  showErrorDialog(context, 'Invalid email');
                } else if (e.code == 'email-already-in-use') {
                  showErrorDialog(context, 'Email already in use');
                } else if (e.code == 'weak-password') {
                  showErrorDialog(context, 'Weak password');
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
            child: const Text('Regester'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login/', (route) => false);
            },
            child: const Text('Already registered? Login now.'),
          ),
        ],
      ),
    );
  }
}
