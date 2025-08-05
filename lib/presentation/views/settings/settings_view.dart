import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/widgets/shared/leading_rounded_icon_button.dart';

class SettingsView extends StatelessWidget {
  static const name = "settings-view";

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // quita la flecha de "back"
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 25,
        toolbarHeight: 100, // título a la izquierda
        title: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            AppLocalizations.of(context)!.config_title,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
        ),
        actions: [
          LeadingRoundedIconButton(
            icon: Icons.close,
            backgroundColor: Colors.transparent,
            iconColor: colors.onSurface,
            iconSize: 28,
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.push("/app-settings");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest.withAlpha(150),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      // Icon(Icons.settings, color: colors.onSurface, size: 30),
                      Text(
                        AppLocalizations.of(context)!.app_setting_title,
                        style: AppTextStyles.titlesForListSettings(context),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 17,
                        color: colors.onSurface,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
