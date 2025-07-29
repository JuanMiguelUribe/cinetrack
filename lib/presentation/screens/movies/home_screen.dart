import 'package:movieflex/presentation/widgets/shared/botton_nav_with_animation.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  final StatefulNavigationShell childView;
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
