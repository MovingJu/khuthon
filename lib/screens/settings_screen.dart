import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  User? _user;

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // 로그인 취소됨
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      setState(() {
        _user = userCredential.user;
      });
    } catch (e) {
      print('로그인 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google 로그인')),
      body: Center(
        child:
            _user == null
                ? ElevatedButton(
                  onPressed: _signInWithGoogle,
                  child: const Text('구글로 로그인하기'),
                )
                : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('안녕하세요, ${_user!.displayName}!'),
                    Text('이메일: ${_user!.email}'),
                    CircleAvatar(
                      backgroundImage: NetworkImage(_user!.photoURL ?? ''),
                      radius: 40,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        setState(() {
                          _user = null;
                        });
                      },
                      child: const Text('로그아웃'),
                    ),
                  ],
                ),
      ),
    );
  }
}
