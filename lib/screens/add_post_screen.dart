import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/resources/firestore_methods.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:instagram_clone_flutter/widgets/my_video_player.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  File? _video;
  late VideoPlayerController _videoPlayerController;
  // late VideoPlayerController? _cameraVideoPlayerController;
  bool isImage = false;
  bool isVideo = false;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                    isImage = true;
                    isVideo = false;
                  });
                }),
            // SimpleDialogOption(
            //     padding: const EdgeInsets.all(20),
            //     child: const Text('Record a video'),
            //     onPressed: () async {
            //       Navigator.pop(context);
            //       XFile? file = await pickVideo(ImageSource.camera);
            //       if (file != null) {
            //         setState(() {
            //           isVideo = true;
            //         });

            //         _videoPlayerController =
            //             VideoPlayerController.file(File(file.path))
            //               ..initialize().then((_) {
            //                 setState(() {});
            //                 _videoPlayerController.play();
            //               });
            //       }
            //     }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose Image from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List? fileDataImage =
                      await pickImage(ImageSource.gallery);

                  if (fileDataImage != null) {
                    setState(() {
                      _file = fileDataImage;
                      isImage = true;
                      isVideo = false;
                    });
                  }
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose Video from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();

                  XFile pickedFile = await pickVideo(ImageSource.gallery);
                  File myvideo = File(pickedFile.path);

                  _videoPlayerController = VideoPlayerController.file(myvideo)
                    ..initialize().then((_) {
                      setState(() {});
                      _videoPlayerController.play();
                    })
                    ..setLooping(true);
                  setState(() {
                    isVideo = true;
                    _video = myvideo;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _titleController.text,
        _descriptionController.text,
        _urlController.text,
        _file,
        _video,
        isVideo,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        if (context.mounted) {
          showSnackBar(
            context,
            'Posted!',
          );
        }
        clearImage();
      } else {
        if (context.mounted) {
          showSnackBar(context, res);
        }
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
      isImage = false;
      isVideo = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return _file == null && !isVideo
        ? Center(
            child: IconButton(
              icon: const Icon(
                Icons.upload,
              ),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text(
                'Post to',
              ),
              centerTitle: false,
              actions: <Widget>[
                TextButton(
                  onPressed: () => postImage(
                    userProvider.getUser.uid,
                    userProvider.getUser.username,
                    userProvider.getUser.photoUrl,
                  ),
                  child: const Text(
                    "Post",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )
              ],
            ),
            // POST FORM
            body: ListView(
              children: <Widget>[
                isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                            hintText: "Write a title...",
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //     userProvider.getUser.photoUrl,
                    //   ),
                    // ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            hintText: "Write a caption...",
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (isVideo)
                      _videoPlayerController.value.isInitialized
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: VideoPlayer(_videoPlayerController)),
                              ))
                          : Container()

                    // if(isVideo)
                    //   Container(
                    //     child: FloatingActionButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           _videoPlayerController.value.isPlaying
                    //               ? _videoPlayerController.pause()
                    //               : _videoPlayerController.play();
                    //         });
                    //       },
                    //       child: Icon(
                    //         _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    //       ),
                    //     ),
                    //   )
                    else
                      SizedBox(
                        height: 45.0,
                        width: 45.0,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                              image: MemoryImage(_file!),
                            )),
                          ),
                        ),
                      ),
                  ],
                ),
                if (isVideo)
                  Positioned(
                    top: 0.0,
                    child: Container(
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _videoPlayerController.value.isPlaying
                                ? _videoPlayerController.pause()
                                : _videoPlayerController.play();
                          });
                        },
                        child: Icon(
                          _videoPlayerController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: _urlController,
                        decoration: const InputDecoration(
                            hintText: "Enter the URL...",
                            border: InputBorder.none),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          );
  }
}
