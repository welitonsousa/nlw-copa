import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';

class AppInput extends StatelessWidget {
  final String label;
  final TextEditingController? controller;

  const AppInput({super.key, this.label = "", this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppTheme.colors.yellow600,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: TextStyle(color: AppTheme.colors.yellow600),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.colors.yellow600, width: 1),
        ),
        focusColor: AppTheme.colors.yellow600,
      ),
    );
  }
}
