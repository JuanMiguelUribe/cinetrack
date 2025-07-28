import 'package:flutter/material.dart';
import 'package:cinetrack/config/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:cinetrack/config/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0, isDarkMode: false).getTheme(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
    );
  }
}
