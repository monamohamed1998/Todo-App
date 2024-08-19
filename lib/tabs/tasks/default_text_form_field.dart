import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxlines = 1,
      this.validator,
      this.icon,
      this.isPassword = false,
      this.onChanged});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final int? maxlines;
  final bool? isPassword;
  final Icon? icon;
  // final VoidCallback onchange;
  final void Function(String)? onChanged;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool isObsecure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword!
            ? IconButton(
                icon: Icon(
                  isObsecure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  if (widget.isPassword == true) {
                    isObsecure = !isObsecure;
                    setState(() {});
                  }
                },
              )
            : widget.icon,
      ),
      maxLines: widget.maxlines,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isObsecure,
      onChanged: widget.onChanged,
    );
  }
}
