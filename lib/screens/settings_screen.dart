import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user; // ✅ 로그인한 유저 정보 저장

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('사용자가 로그인 취소함');
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
        _user = userCredential.user; // ✅ 로그인 성공 시 유저 정보 저장
      });

      print('로그인 성공: ${_user?.displayName}');
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
                  onPressed: _handleGoogleSignIn,
                  child: const Text('구글로 로그인하기'),
                )
                : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(_user?.photoURL ?? ''),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _user?.displayName ?? '이름 없음',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _user?.email ?? '이메일 없음',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        await _googleSignIn.signOut();
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
