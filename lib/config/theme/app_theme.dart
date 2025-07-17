import 'package:flutter/material.dart';

const colorList = <Color>[
  Color(0xFF1565C0), // Azul fuerte
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
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.selectedColor = 0, this.isDarkMode = false})
    : assert(
        selectedColor >= 0 && selectedColor < colorList.length,
        "Selected color index is out of range",
      );

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorList[selectedColor],
  );
}
