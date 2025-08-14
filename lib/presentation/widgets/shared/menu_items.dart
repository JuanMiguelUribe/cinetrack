import 'package:flutter/material.dart';
import 'package:movieflex/l10n/app_localizations.dart';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.reload,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8), // espacio entre texto e icono
                const Icon(Icons.refresh_rounded, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
