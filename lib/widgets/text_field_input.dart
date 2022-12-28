import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/main.dart';

OutlineInputBorder inputBorder = OutlineInputBorder(
  borderSide: Divider.createBorderSide(navigatorKey.currentContext),
);

class TextFieldInput extends TextFormField {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validation;

  TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    this.validation,
    required this.hintText,
    required this.textInputType,
  }) : super(
            key: key,
            controller: textEditingController,
            validator: validation,
            decoration: InputDecoration(
                hintText: hintText,
                border: inputBorder,
                focusedBorder: inputBorder,
                enabledBorder: inputBorder,
                contentPadding: const EdgeInsets.all(8)),
            keyboardType: textInputType,
            obscureText: isPass);
}
