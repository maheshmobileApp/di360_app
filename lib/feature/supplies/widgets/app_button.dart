import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData? prefixIcon;

  final bool outlined;
  final bool isLoading;

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;

  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double fontSize;

  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.prefixIcon,
    this.outlined = false,
    this.isLoading = false,
    this.backgroundColor = Colors.deepOrange,
    this.borderColor = Colors.deepOrange,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.height = 52,
    this.borderRadius = 12,
    this.fontSize = 16,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: padding,
          backgroundColor:
              outlined ? Colors.white : backgroundColor,
          foregroundColor:
              outlined ? textColor : Colors.white,
          side: BorderSide(
            color: borderColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: outlined
                      ? borderColor
                      : Colors.white,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[
                    Icon(
                      prefixIcon,
                      color: outlined
                          ? iconColor
                          : Colors.white,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize,
                      color: outlined
                          ? textColor
                          : Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}