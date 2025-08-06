import 'dart:ui';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/config/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

final colorListProvider = Provider((ref) => colorList);

final isDarkModeProvider = StateProvider<bool>((ref) => false);

final selectedColorProvider = StateProvider<int>((ref) => 0);

//Controller o Notifier
class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme()) {
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    final colorIndex = prefs.getInt('selectedColor') ?? 0;
    final customColorValue = prefs.getInt('customColor');

    state = AppTheme(
      isDarkMode: isDark,
      selectedColor: colorIndex,
      customColor: customColorValue != null ? Color(customColorValue) : null,
    );
  }

  void toggleDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final newMode = !state.isDarkMode;
    await prefs.setBool('isDarkMode', newMode);

    state = state.copyWith(
      isDarkMode: newMode,
      selectedColor: state.selectedColor,
      customColor: state.customColor,
    );
  }

  void changeColorIndex(int newIndex) async {
    state = state.copyWith(
      selectedColor: newIndex,
      customColor: null,
    ); // ← importante
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedColor', newIndex);
    await prefs.remove('customColor');
  }

  void changeCustomColor(Color? color) async {
    state = state.copyWith(customColor: color, selectedColor: 0);
    final prefs = await SharedPreferences.getInstance();

    if (color == null) {
      await prefs.remove('customColor');
      await prefs.setInt('selectedColor', 0);
    } else {
      await prefs.setString('customColor', color.toHexString());
      await prefs.setInt('selectedColor', 0);
    }
  }

  void resetToDefault() async {
    state = AppTheme(); // resetea todo
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('customColor');
    await prefs.remove('selectedColor');
  }
}
