import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LinkScreen extends StatefulWidget {
  final String linkURL;

  const LinkScreen({required this.linkURL, Key? key}) : super(key: key);

  @override
  _LinkScreenState createState() => _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          if (progress == 80) {
            setState(() {
              isLoading = false;
            });
          }
        },
      ))
      ..loadRequest(
        Uri.parse(widget.linkURL),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarBackgroundColor,
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/NEWMS_SVG.svg',
          color: primaryColor,
          height: 32,
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
