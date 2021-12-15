import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
import 'package:instagram_clone_flutter/screens/login_screen.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Making sure connection to future has been made
        if (snapshot.connectionState == ConnectionState.done) {
          // Checking if the snapshot has any data or not
          if (snapshot.hasData) {
            // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
            return LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout
                return webScreenLayout;
              }
              return mobileScreenLayout;
            });
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
        }

        // means connection to future hasnt been made yet
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // if none of the conditions match, user has to login
        return const LoginScreen();
      },
    );
  }
}
