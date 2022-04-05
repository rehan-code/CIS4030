import 'package:flutter/material.dart';

class DetailText extends StatelessWidget {
  final String detailText;
  final FontWeight fontWeight;
  final double fontSize;

  DetailText(this.detailText, this.fontWeight, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Text(detailText,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ));
  }
}
