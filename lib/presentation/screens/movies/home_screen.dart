import 'package:cinetrack/presentation/widgets/shared/botton_nav_with_animation.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  final Widget childView;
  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: childView,
      bottomNavigationBar: BottonNavWithAnimation(),
    );
  }
}
