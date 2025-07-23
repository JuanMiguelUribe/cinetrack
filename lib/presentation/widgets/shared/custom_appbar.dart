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
              const SizedBox(width: 10),

              RichText(
                text: TextSpan(
                  style: GoogleFonts.robotoFlex(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "Movie",
                      style: TextStyle(color: colors.onSurface),
                    ),
                    TextSpan(
                      text: "Dex",
                      style: TextStyle(color: colors.primary),
                    ),
                  ],
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
