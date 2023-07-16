import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:instagram_clone_flutter/models/user.dart' as model;
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone_flutter/widgets/like_animation.dart';
import 'package:instagram_clone_flutter/resources/firestore_methods.dart';

class CommentCard extends StatefulWidget {
  final snap;
  CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.snap.data()['profilePic']),
              radius: 24,
            ),
            title: Row(
              children: [
                Text(
                  widget.snap.data()['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(width: 10),
                Text(
                  DateFormat.yMMMd()
                      .format(widget.snap.data()['datePublished'].toDate()),
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
            subtitle: Text(
              widget.snap.data()['text'],
              style: TextStyle(fontSize: 14),
            ),
            trailing: GestureDetector(
              child: AnimatedLikeButton(
                isLiked: widget.snap['likes'].contains(user.uid),
                size: 24,
              ),
              onTap: () => FireStoreMethods().likeComment(
                widget.snap['uid'].toString(),
                widget.snap['commentId'].toString(),
                user.uid,
                widget.snap['likes'],
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class AnimatedLikeButton extends StatelessWidget {
  final bool isLiked;
  final double size;

  AnimatedLikeButton({Key? key, required this.isLiked, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
        size: size,
      ),
    );
  }
}
