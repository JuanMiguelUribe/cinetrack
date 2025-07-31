import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  final String label;
  final double size;
  const GenreChip({super.key, required this.label, this.size = 1.0});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * size, vertical: 6 * size),
      margin: EdgeInsets.symmetric(horizontal: 4 * size, vertical: 4 * size),
      decoration: BoxDecoration(
        color: colors.primary.withOpacity(
          0.5,
        ), // fondo oscuro semi-transparente
        borderRadius: BorderRadius.circular(20 * size),
        // bordes ovalados
      ),
      child: Text(
        '#$label',
        style: TextStyle(
          color: colors.onSurface,
          fontWeight: FontWeight.w500,
          fontSize: 11 * size,
        ),
      ),
    );
  }
}
