import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/screens/add_post_screen.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('Search Screen'),
  AddPostScreen(),
  Text('Notifications Screen'),
  Text('Profile Screen'),
];