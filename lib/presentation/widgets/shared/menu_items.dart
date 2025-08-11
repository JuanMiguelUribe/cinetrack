import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  final VoidCallback? refresh;
  const MenuItems({super.key, this.refresh});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Container(height: 40, color: colors.surfaceDim),
        Center(
          child: TextButton(
            onPressed: refresh,
            style: TextButton.styleFrom(
              // backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: const Text(
              "Hola",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
