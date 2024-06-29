import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.elevation,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.blue, // Default background color
        foregroundColor: textColor ?? Colors.white, // Default text color
        elevation: elevation ?? 5, // Default elevation
        shadowColor: Colors.grey.withOpacity(0.5),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Default padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0), // Default border radius
          side: BorderSide(
            color: borderColor ?? Colors.blueAccent, // Default border color
            width: borderWidth ?? 2, // Default border width
          ),
        ),
      ),
      child: Text(
        text,
        style: textStyle ?? TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ), // Default text style
      ),
    );
  }
}
