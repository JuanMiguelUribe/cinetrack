import 'package:flutter/material.dart';

class CustomBottomNavigationbar extends StatelessWidget {
  const CustomBottomNavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        height: 72,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: colors.onSurface.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: colors.onSurface.withOpacity(0.3),
              offset: Offset(0, 20),
              blurRadius: 20,
            ),
          ],
        ),
        // child: Row(children: [List.generate(bottomnavIte, generator)],),
      ),
    );
  }
}
