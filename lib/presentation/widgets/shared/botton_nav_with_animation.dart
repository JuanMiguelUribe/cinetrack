import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cinetrack/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../infraestructure/models/navigationbar/section_model.dart';

class BottonNavWithAnimation extends StatefulWidget {
  const BottonNavWithAnimation({super.key});

  @override
  State<BottonNavWithAnimation> createState() => _BottonNavWithAnimationState();
}

List<NavBarItem> getNavItems(BuildContext context) {
  return [
    NavBarItem(
      label: AppLocalizations.of(context)!.homeNav,
      icon: Icons.home,
      index: 0,
    ),
    NavBarItem(
      label: AppLocalizations.of(context)!.categoriasNav,
      icon: Icons.category_sharp,
      index: 1,
    ),
    NavBarItem(
      label: AppLocalizations.of(context)!.favsNav,
      icon: Icons.favorite_rounded,
      index: 2,
    ),
  ];
}

class _BottonNavWithAnimationState extends State<BottonNavWithAnimation> {
  int selectedNavIndex = 0;

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go("/");
        break;
      case 1:
        context.go("/");
        break;
      case 2:
        context.go("/favorites");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final items = getNavItems(context);

    return SafeArea(
      bottom: true,

      child: FadeIn(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: 72,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.inverseSurface.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: colors.shadow.withOpacity(0.3),
                        offset: const Offset(0, 10),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Row(
                    children: List.generate(
                      items.length,
                      (index) => Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedNavIndex = index;
                            });
                            onItemTapped(context, index);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _AnimatedBar(
                                colors: colors,
                                isActive: selectedNavIndex == index,
                              ),
                              Opacity(
                                opacity: selectedNavIndex == index ? 1 : 0.5,
                                child: Icon(
                                  items[index].icon,
                                  color: selectedNavIndex == index
                                      ? colors.inversePrimary
                                      : colors.surface,
                                  size: 25,
                                ),
                              ),
                              Opacity(
                                opacity: selectedNavIndex == index ? 1 : 0.5,
                                child: Text(
                                  items[index].label,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: selectedNavIndex == index
                                        ? colors.inversePrimary
                                        : colors.surface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedBar extends StatelessWidget {
  const _AnimatedBar({required this.colors, required this.isActive});

  final ColorScheme colors;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.5),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: isActive
          ? Container(
              key: const ValueKey('bar'),
              margin: const EdgeInsets.only(bottom: 2),
              height: 4,
              width: 30,
              decoration: BoxDecoration(
                color: colors.inversePrimary,
                borderRadius: BorderRadius.circular(12),
              ),
            )
          : const SizedBox(key: ValueKey('empty'), height: 4, width: 0),
    );
  }
}
