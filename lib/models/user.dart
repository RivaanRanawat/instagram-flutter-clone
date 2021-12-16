import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final Map followers;
  final Map following;

  const User(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following});

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        uid: json["uid"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        bio: json["bio"],
        followers: json["followers"],
        following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
