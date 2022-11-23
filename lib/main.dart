import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/views/login_view.dart';
import 'package:myapp/views/main_ui.dart';
import 'package:myapp/views/register_view.dart';
import 'package:myapp/views/verify_email_view.dart';
import 'dart:developer' show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegesterView(),
        '/email_verification/': (context) => VerifyEmailView(),
        '/main_ui/': (context) => MainUI(),
      },
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            log(user.toString());
            if (user != null) {
              if (user.emailVerified) {
                return const MainUI();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        } //switch
      },
    );
  }
}

// git status && git add --all && git commit -am "step-x" && git push && git tag "step-x" && git push --tags
