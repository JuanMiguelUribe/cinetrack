import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
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
                      text: "Flex",
                      style: TextStyle(color: colors.primary),
                    ),
                  ],
                ),
              ),

              Spacer(),
              // IconButton(
              //   onPressed: () async {
              //     // ...
              //   },
              //   icon: Icon(Icons.line_style_sharp, color: colors.onSurface),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
