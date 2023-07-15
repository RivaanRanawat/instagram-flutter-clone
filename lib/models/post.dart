import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String title;
  final String description;
  final String uid;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String? postUrl;
  final String? videoUrl;
  final bool isVideo;
  final String profImage;
  final String linkURL;

  const Post({
    required this.title,
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    this.postUrl,
    this.videoUrl,
    required this.isVideo,
    required this.profImage,
    required this.linkURL,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        title: snapshot["title"],
        description: snapshot["description"],
        uid: snapshot["uid"],
        likes: snapshot["likes"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        videoUrl: snapshot['videoUrl'],
        isVideo: snapshot['isVideo'],
        profImage: snapshot['profImage'],
        linkURL: snapshot['linkURL']);
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'videoUrl': videoUrl,
        'isVideo': isVideo,
        'profImage': profImage,
        'linkURL': linkURL,
      };
}
