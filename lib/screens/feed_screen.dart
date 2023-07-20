import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_flutter/screens/add_post_screen.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/global_variable.dart';
import 'package:instagram_clone_flutter/widgets/post_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final specificUID =
      'Eiq8trOXJkcCz5agwbJhwYCXMyJ2'; // replace with the specific UID
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: isPortrait
          ? AppBar(
              backgroundColor: AppBarBackgroundColor,
              centerTitle: true,
              title: SvgPicture.asset(
                'assets/NEWMS_SVG.svg',
                color: primaryColor,
                height: 32,
              ),
              actions: [
                  StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, AsyncSnapshot<User?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.data?.uid == specificUID) {
                            return IconButton(
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: ActionIconColor,
                              ),
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const AddPostScreen()
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      })
                ])
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
        },
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts')
              .orderBy('timestamp', descending: true)
              .snapshots(),
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
