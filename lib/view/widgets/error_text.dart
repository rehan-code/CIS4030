import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String errorText;
  final FontWeight fontWeight;
  final double fontSize;

  ErrorText(this.errorText, this.fontWeight, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorText,
        style: TextStyle(
          color: Colors.red,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
