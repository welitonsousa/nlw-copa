import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/core/theme/app_theme.dart';

class AppInput extends StatelessWidget {
  final String label;
  final int? maxLength;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextAlign textAlign;
  final bool enable;
  final List<TextInputFormatter>? formatters;
  const AppInput(
      {super.key,
      this.label = "",
      this.controller,
      this.maxLength,
      this.enable = true,
      this.textAlign = TextAlign.start,
      this.textInputType,
      this.formatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      cursorColor: AppTheme.colors.yellow600,
      controller: controller,
      keyboardType: textInputType,
      keyboardAppearance: Brightness.dark,
      textCapitalization: TextCapitalization.characters,
      inputFormatters: [
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
        if (formatters != null) ...formatters!
      ],
      textAlign: textAlign,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelAlignment: FloatingLabelAlignment.center,
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
