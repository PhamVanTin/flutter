import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth/admin_or_user.dart';
import 'package:flutter_application_1/Auth/login.dart';
import 'package:flutter_application_1/Auth/login2.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser;
            return AdminOrUser(
              user: user,
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
