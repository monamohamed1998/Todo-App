import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
   DefaultTextFormField({required this.controller,required this.hintText,this.maxlines, this.validator});
  TextEditingController controller;
  String? Function(String?)? validator;
  String hintText;
  int? maxlines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      maxLines: maxlines,
      validator: validator,
    );
  }
}