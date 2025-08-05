import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movieflex/config/theme/app_theme.dart';
import 'package:movieflex/presentation/providers/theme/theme_provider.dart';

void showColorPicker(BuildContext context, WidgetRef ref) {
  Color pickerColor = colorList[ref.watch(themeNotifierProvider).selectedColor];

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Selecciona un color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            hexInputBar: true,

            pickerColor: pickerColor,
            pickerAreaBorderRadius: BorderRadius.circular(30),
            onColorChanged: (color) {
              pickerColor = color;
            },
            enableAlpha: false,
            labelTypes: const [ColorLabelType.rgb],
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Aplicar el nuevo color
              ref
                  .read(themeNotifierProvider.notifier)
                  .changeCustomColor(pickerColor);
              context.pop();
            },
            child: const Text('Aplicar'),
          ),
        ],
      );
    },
  );
}
