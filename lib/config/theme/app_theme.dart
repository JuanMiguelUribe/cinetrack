import 'package:flutter/material.dart';

const colorList = <Color>[
  Color.fromARGB(255, 40, 98, 245), // Azul fuerte
  Color(0xFF42A5F5), // Azul cielo
  Color(0xFF009688), // Verde azulado
  Color(0xFF4CAF50), // Verde
  Color(0xFFFFA726), // Naranja suave
  Color(0xFFFF7043), // Naranja rojizo
  Color(0xFFD32F2F), // Rojo intenso
  Color(0xFF7E57C2), // Morado
  Color(0xFFEC407A), // Rosado fuerte
  Color(0xFF5D4037), // Marrón oscuro
  Color(0xFF78909C), // Gris azulado
  Color(0xFF546E7A), // Azul grisáceo
  Color(0xFF5D547A), // Azul grisáceo
  Color(0xFF7A6154), // Azul grisáceo
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;
  final Color? customColor;

  AppTheme({this.selectedColor = 0, this.isDarkMode = false, this.customColor});

  ThemeData getTheme() {
    final color = customColor ?? colorList[selectedColor % colorList.length];
    return ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: color,
    );
  }

  AppTheme copyWith({
    bool? isDarkMode,
    int? selectedColor,
    Color? customColor,
  }) {
    return AppTheme(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      selectedColor: selectedColor ?? this.selectedColor,
      customColor: customColor ?? this.customColor,
    );
  }
}
