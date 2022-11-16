import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';

class DetailOption extends StatelessWidget {
  final String title;
  final bool selected;
  final void Function()? onTap;
  const DetailOption({
    super.key,
    this.title = "",
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap?.call,
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: selected ? AppTheme.colors.gray600 : null,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }
}
