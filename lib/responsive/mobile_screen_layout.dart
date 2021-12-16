import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => FirebaseAuth.instance.signOut(),
          child: Text(
            userProvider.getUser.username,
          ),
        ),
      ),
    );
  }
}
