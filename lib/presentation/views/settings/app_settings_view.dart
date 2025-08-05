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
            padding: const EdgeInsets.only(left: 30),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest.withAlpha(150),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _ThemeSection(isDarkMode: isDarkMode),
            ),
          ),
          const SizedBox(height: 8),

          ElevatedButton.icon(
            icon: const Icon(Icons.palette),
            label: const Text("Elegir color personalizado"),
            onPressed: () => showColorPicker(context, ref),
          ),
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('customColor');
              ref.read(themeNotifierProvider.notifier).changeCustomColor(null);
            },
            child: const Text("Restablecer color predeterminado"),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "App Color",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
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
                "App Theme",
                style: AppTextStyles.titlesForAppSettingsView(context),
              ),
              const Text("Choose how you want to view the app.", maxLines: 2),
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
