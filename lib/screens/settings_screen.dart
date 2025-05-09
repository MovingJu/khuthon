import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../button/sync_button.dart';
import '../services/syncdata_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;

  @override
  void initState() {
    super.initState();
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        _user = currentUser;
      });
    }
  }

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
        _user = userCredential.user;
      });

      print('로그인 성공: ${_user?.displayName}');
    } catch (e) {
      print('로그인 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Google 로그인'),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              tooltip: '내 농장 동기화',
              onPressed: () async {
                try {
                  await SyncService.sync();
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('동기화가 완료되었습니다!')),
                  );
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('동기화 실패: $e')),
                  );
                }
              },
            ),
          ],
      ),
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
