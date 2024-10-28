import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: child,
    );
  }
}
