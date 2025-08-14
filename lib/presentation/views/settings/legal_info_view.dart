import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movieflex/l10n/app_localizations.dart';

class LegalInfoView extends StatelessWidget {
  const LegalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // quita la flecha de "back"
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        leadingWidth: 40,
        toolbarHeight: 50,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_ios_outlined),
        ), // título a la izquierda
      ),
      body: ListView(
        children: [
          //*Titulo
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                AppLocalizations.of(context)!.legalInfo,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          //*DESCRIPCIÓN
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.legalDescription,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              onPressed: () {
                showLicensePage(
                  context: context,
                  applicationName: 'MovieFlex',
                  applicationVersion: '1.0.0',
                );
              },
              child: Text(l10n.viewLicenses),
            ),
          ),
        ],
      ),
    );
  }
}
