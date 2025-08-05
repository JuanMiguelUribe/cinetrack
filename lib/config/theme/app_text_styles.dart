import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Título general de secciones (ej: "Populares", "Actores", etc.)
  static TextStyle sectionTitle(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GoogleFonts.robotoFlex(
      fontSize: 20,
      color: colors.onSurface,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
    );
  }

  // Nombre del actor
  static TextStyle actorName(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GoogleFonts.robotoFlex(
      fontSize: 12,
      color: colors.onSurface,
      fontWeight: FontWeight.w500,
    );
  }

  // Rol del actor (personaje)
  static TextStyle characterName(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GoogleFonts.robotoFlex(
      fontSize: 13,
      color: colors.onSurface,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle titleMovieSearch(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GoogleFonts.urbanist(
      fontSize: 17,
      color: colors.onSurface,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle overviewMovieSearch(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GoogleFonts.inter(
      fontSize: 12,
      color: colors.onSurface,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle typeMovieSearch(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GoogleFonts.poppins(
      fontSize: 14,
      color: colors.onSurface,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle titleFavorites(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GoogleFonts.roboto(
      fontSize: 28,
      color: colors.primary,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle titlesForDetailScreen(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GoogleFonts.roboto(
      fontSize: 25,
      color: colors.primary,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle videoNameTitle(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextStyle(
      fontSize: 14,
      color: colors.onSurface,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle videoTypeTitle(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;

    return TextStyle(
      fontSize: 14,
      color: Colors.grey,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle titlesForListSettings(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextStyle(
      fontSize: 17,
      color: colors.onSurface,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle titlesForAppSettingsView(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextStyle(
      fontSize: 20,
      color: colors.onSurface,
      fontWeight: FontWeight.w600,
    );
  }

  // Puedes seguir agregando más: descripción, botón, etc.
}
