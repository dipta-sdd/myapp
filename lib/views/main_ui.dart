import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum MenuAction { logout }

class MainUI extends StatefulWidget {
  const MainUI({super.key});

  @override
  State<MainUI> createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  log(shouldLogout.toString());
                  if (shouldLogout) {
                    // ignore: use_build_context_synchronously
                    log('logout');
                    await FirebaseAuth.instance.signOut();
                    final user = FirebaseAuth.instance.currentUser;
                    log(user.toString());
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login/',
                      (_) => false,
                    );
                  }
                  break;
              }
            },
            itemBuilder: ((context) {
              return [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text('Log Out'),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Icon(
                        Icons.logout_outlined,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ];
            }),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: const [
            Text('Hello user'),
            Text('hala gaira'),
          ],
        ),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('Are you sure you want to logout'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Logout'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      })).then((value) => value ?? false);
}
