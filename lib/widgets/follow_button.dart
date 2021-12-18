import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Function()? function;

  const FollowButton(
      {Key? key,
      required this.text,
      required this.backgroundColor,
      required this.textColor,
      required this.borderColor,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2.0),
      child: TextButton(
          onPressed: function,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            alignment: Alignment.center,
            child: Text(text,
                style:
                    TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            width: 250.0,
            height: 27.0,
          )),
    );
  }
}
