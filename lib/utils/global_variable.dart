import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/screens/add_post_screen.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';
import 'package:instagram_clone_flutter/screens/profile_screen.dart';
import 'package:instagram_clone_flutter/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  // const AddPostScreen(),
  // const Text('notifications'),
  // StreamBuilder(
  //     stream: FirebaseAuth.instance.authStateChanges(),
  //     builder: (context, AsyncSnapshot<User?> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.active) {
  //         // if (snapshot.data!=null && snapshot.data?.uid != null) {
  //           return ProfileScreen(
  //             uid: snapshot.data!.uid,
  //           );
            
          
  //       // } else {
  //       //   return Container();
  //       // }
  //     })
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
