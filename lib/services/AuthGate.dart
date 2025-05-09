import 'dart:html' as html; // 웹 세션 스토리지용
import 'package:flutter/foundation.dart' show kIsWeb; // kIsWeb 확인용
import 'package:flutter/material.dart';
import 'package:khuthon/screens/home_screen.dart';
import 'package:khuthon/screens/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool? _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() {
    // 모바일에서는 Firebase Auth 상태만 확인
    final currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      _isLoggedIn = currentUser != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn == true) {
      return const HomePage();
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const SettingsScreen();
        }
      },
    );
  }
}
