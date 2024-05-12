import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/pages/login_page.dart';
import 'home_page.dart';

class AuthPage extends StatelessWidget {
   AuthPage({super.key,});

  final GlobalKey<ScaffoldState> _homePageKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if (snapshot.hasData) {
          //   return HomePage(scaffoldKey: _homePageKey);
          // } else {
            return LoginPage();
          // }
        },
      ),
    );
  }
}