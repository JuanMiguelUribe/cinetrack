import 'package:flutter/material.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';

Widget buildSectionDivider(String title, BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Row(
      children: [
        const SizedBox(width: 10),

        Text(title, style: AppTextStyles.titleFavorites(context)),

        Expanded(
          child: Divider(color: colors.primary, thickness: 1, indent: 10),
        ),
        const SizedBox(width: 10),
      ],
    ),
  );
}
