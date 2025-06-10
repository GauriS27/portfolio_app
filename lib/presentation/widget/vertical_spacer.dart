import 'package:flutter/material.dart';

class VerticalSpacer extends StatelessWidget {
  final double? boxHeight;
  const VerticalSpacer({super.key, this.boxHeight = 15});
  const VerticalSpacer.small({this.boxHeight = 4, super.key});
  const VerticalSpacer.medium({this.boxHeight = 10, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight,
    );
  }
}
