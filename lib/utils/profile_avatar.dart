import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? url;
  final double? radius;
  final Color? backgroundColor;
  const ProfileAvatar({
    Key? key,
    required this.url,
    this.radius,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage:
            const NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
        backgroundColor: backgroundColor,
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(url!),
      backgroundColor: backgroundColor,
    );
  }
}
