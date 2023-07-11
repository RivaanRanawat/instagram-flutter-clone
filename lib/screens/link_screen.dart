import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LinkScreen extends StatefulWidget {
  final String linkURL;

  const LinkScreen({required this.linkURL, Key? key}) : super(key: key);

  @override
  _LinkScreenState createState() => _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.linkURL),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Screen'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
