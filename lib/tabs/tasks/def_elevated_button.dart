import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class DefElevatedbutton extends StatelessWidget {
  const DefElevatedbutton(
      {super.key, required this.label, required this.onpressed});
  final VoidCallback onpressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 52)),
      onPressed: () {
        onpressed();
      },
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppTheme.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
