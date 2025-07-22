import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Icon(
                Icons.local_movies_outlined,
                color: colors.primary,
                size: 30,
              ),
              const SizedBox(width: 10),
              Spacer(),
              Text(
                "CineTrack",
                style: GoogleFonts.robotoFlex(
                  fontSize: 32,
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                  // background:
                  // Puedes probar: 'Cinzel', 'Bebas Neue', 'Playfair Display', etc.
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, color: colors.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
