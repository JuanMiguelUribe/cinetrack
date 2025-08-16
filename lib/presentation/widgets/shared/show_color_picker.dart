import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movieflex/config/theme/app_theme.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/providers/theme/theme_provider.dart';

void showColorPicker(BuildContext context, WidgetRef ref) {
  final theme = ref.watch(themeNotifierProvider);
  Color pickerColor = theme.customColor ?? colorList[theme.selectedColor];
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Selecciona un color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            hexInputBar: true,
            pickerColor: pickerColor,

            showLabel: false,
            displayThumbColor: false,
            pickerAreaBorderRadius: BorderRadius.circular(10),
            onColorChanged: (color) {
              pickerColor = color;
            },
            enableAlpha: false,
            labelTypes: const [ColorLabelType.rgb],
            pickerAreaHeightPercent: 0.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text((AppLocalizations.of(context)!.cancel_button)),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(colorAppliedProvider.notifier).state = true;

              // Aplicar el nuevo color
              ref
                  .read(themeNotifierProvider.notifier)
                  .changeCustomColor(pickerColor);
              context.pop();
            },
            child: Text(AppLocalizations.of(context)!.apply_button),
          ),
        ],
      );
    },
  );
}
