import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => FirebaseAuth.instance.signOut(),
          child: Text(
            'yo'
          ),
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
              backgroundColor: mobileBackgroundColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home,
                        color: (_page == 0) ? Colors.white : Colors.grey),
                    label: '',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search,
                        color: (_page == 1) ? Colors.white : Colors.grey),
                    label: '',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle,
                        color: (_page == 2) ? Colors.white : Colors.grey),
                    label: '',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.star,
                        color: (_page == 3) ? Colors.white : Colors.grey),
                    label: '',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person,
                        color: (_page == 4) ? Colors.black : Colors.grey),
                    label: '',
                    backgroundColor: Colors.white),
              ],
              onTap: (int page) {},
              currentIndex: _page,
            ),
    );
  }
}
