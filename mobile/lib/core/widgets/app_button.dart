import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? color;
  final Widget? icon;
  final String? title;
  final Function? onTap;
  final bool loading;
  const AppButton({
    super.key,
    this.backgroundColor,
    this.title,
    this.onTap,
    this.icon,
    this.color,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroundColor ??
                AppTheme.colors.yellow500.withOpacity(loading ? .5 : 1),
          ),
        ),
        onPressed: () {
          if (!loading) onTap?.call();
        },
        child: Visibility(
          visible: loading,
          replacement: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Theme(
                      data: AppTheme().dark.copyWith(
                          iconTheme:
                              IconThemeData(color: AppTheme.colors.gray900)),
                      child: icon!,
                    )
                  : const SizedBox(),
              Text(
                title?.toUpperCase() ?? '',
                style: TextStyle(color: color ?? AppTheme.colors.gray900),
              ),
              const SizedBox()
            ],
          ),
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: AppTheme.colors.gray900,
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }
}
