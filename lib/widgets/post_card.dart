import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  fetchComments() async {
    commentLen = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.snap['postId'])
        .collection('comments')
        .snapshots()
        .length;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // HEADER SECTION OF THE POST
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 16,
          ).copyWith(right: 0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  widget.snap['profImage'].toString(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.snap['username'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map(
                                  (e) => InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e),
                                    ),
                                    onTap: () {
                                      // delete the post
                                    },
                                  ),
                                )
                                .toList()),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
        ),
        // IMAGE SECTION OF THE POST
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          width: double.infinity,
          child: Image.network(
            widget.snap['postUrl'].toString(),
            fit: BoxFit.cover,
          ),
        ),
        // LIKE, COMMENT SECTION OF THE POST
        Row(
          children: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                ),
                onPressed: () {}),
            IconButton(
                icon: const Icon(
                  Icons.comment_outlined,
                ),
                onPressed: () {}),
            IconButton(
                icon: const Icon(
                  Icons.send,
                ),
                onPressed: () {}),
            Expanded(
                child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  icon: const Icon(Icons.bookmark_border), onPressed: () {}),
            ))
          ],
        ),
        //DESCRIPTION
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${widget.snap['likes'].length} likes',
                    style: Theme.of(context).textTheme.bodyText2,
                  )),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.snap['username'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' ${widget.snap['description']}',
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  child: Text(
                    'View all $commentLen comments',
                    style: const TextStyle(
                      fontSize: 16,
                      color: secondaryColor,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
                onTap: () {},
              ),
              Container(
                child: Text(
                  DateFormat.yMMMd()
                      .format(widget.snap['datePublished'].toDate()),
                  style: const TextStyle(
                    color: secondaryColor,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4),
              ),
            ],
          ),
        )
      ],
    );
  }
}
