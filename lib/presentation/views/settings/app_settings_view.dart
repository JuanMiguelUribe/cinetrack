import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';
import 'package:movieflex/config/theme/app_theme.dart';
// import 'package:movieflex/config/theme/app_theme.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsView extends ConsumerWidget {
  const AppSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    final AppTheme apptheme = ref.watch(themeNotifierProvider);

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //*Titulo
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                AppLocalizations.of(context)!.app_setting_title,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          //*Container de tema
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: colors.surface.withAlpha(250),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: colors.onSurfaceVariant.withAlpha(100),
                    blurRadius: 3,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: _ThemeSection(isDarkMode: isDarkMode),
            ),
          ),
          const SizedBox(height: 15),

          //*Elegir Color de lista
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.title_app_color,
                  style: AppTextStyles.titlesForAppSettingsView(context),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,

                  children: List.generate(colorList.length, (index) {
                    final color = colorList[index];
                    final isSelected =
                        index == apptheme.selectedColor &&
                        apptheme.customColor == null;

                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(themeNotifierProvider.notifier)
                            .changeColorIndex(index);
                      },

                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: isSelected ? 24 : 20,

                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          ElevatedButton.icon(
            icon: const Icon(Icons.palette),
            label: Text(
              AppLocalizations.of(context)!.choose_personalized_color,
            ),
            onPressed: () => showColorPicker(context, ref),
          ),
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('customColor');
              ref.read(themeNotifierProvider.notifier).resetToDefault();
            },
            child: Text(AppLocalizations.of(context)!.reset_color_default),
          ),

          const SizedBox(height: 0),

          //*Seleccion de Idioma
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: colors.surface.withAlpha(250),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: colors.onSurfaceVariant.withAlpha(100),
                    blurRadius: 3,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.language,
                        style: AppTextStyles.titlesForListSettings(context),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: ref.watch(languageProvider),
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? lang) {
                          if (lang != null) {
                            ref
                                .read(languageProvider.notifier)
                                .setLanguage(lang);
                            ref.invalidate(movieRepositoryProvider);

                            ref.invalidate(nowPlayingMoviesProvider);
                            ref.invalidate(popularMoviesProvider);
                            ref.invalidate(topRatedMoviesProvider);
                            ref.invalidate(upcomingMoviesProvider);
                            ref.invalidate(airingTvShowProvider);
                            ref.invalidate(onTheAirTvShowProvider);
                            ref.invalidate(popularTvShowProvider);
                            ref.invalidate(topRatedTvShowProvider);
                          }
                        },
                        items: const [
                          DropdownMenuItem(value: 'en', child: Text("English")),
                          DropdownMenuItem(value: 'es', child: Text("Español")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeSection extends ConsumerWidget {
  const _ThemeSection({required this.isDarkMode});

  final bool isDarkMode;

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Texto
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.title_apptheme,

                style: AppTextStyles.titlesForAppSettingsView(context),
              ),
              Text(
                AppLocalizations.of(context)!.description_apptheme,
                maxLines: 2,
              ),
            ],
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              // ✨ esto centra verticalmente en el Row
              child: IconButton(
                iconSize: 30,
                alignment: Alignment.center,
                onPressed: () {
                  ref.read(themeNotifierProvider.notifier).toggleDarkMode();
                },
                icon: isDarkMode
                    ? const Icon(Icons.dark_mode_outlined)
                    : const Icon(Icons.light_mode_outlined),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
