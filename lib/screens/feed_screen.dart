import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/global_variable.dart';
import 'package:instagram_clone_flutter/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
const FeedScreen({Key? key}) : super(key: key);

@override
State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
final ScrollController _scrollController = ScrollController();

@override
Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
    backgroundColor: width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
    appBar: AppBar(
        backgroundColor: AppBarBackgroundColor,
        centerTitle: true,
        title: SvgPicture.asset(
        'assets/NEWMS_SVG.svg',
        color: primaryColor,
        height: 32,
        ),
        actions: [
        IconButton(
            icon: const Icon(
            Icons.messenger_outline,
            color: ActionIconColor,
            ),
            onPressed: () {},
        ),
        IconButton(
            icon: Icon(
            Icons.notifications_outlined,
            color: ActionIconColor,
            ),
            onPressed: () {},
        ),
        SizedBox(
            width: 10,
        ),
        ],
    ),
    body: RefreshIndicator(
        onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        },
        child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(),
            );
            }
            return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Card(
                elevation: 5.0,
                color: Theme.of(context).colorScheme.background,
                child: PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              ),



            );
        },
        ),
    ),
    );
}
}