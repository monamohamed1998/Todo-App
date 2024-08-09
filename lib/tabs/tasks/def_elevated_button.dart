import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/app_theme.dart';

class DefElevatedbutton extends StatelessWidget {
  DefElevatedbutton({required this.label, required this.onpressed});
  VoidCallback onpressed;
  String label;
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
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppTheme.white, fontSize: 18),
      ),
    );
  }
}
