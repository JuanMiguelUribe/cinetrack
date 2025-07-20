import 'package:cinetrack/infraestructure/models/navigationbar/nav_item_model.dart';
import 'package:flutter/material.dart';

class BottonNavWithAnimation extends StatefulWidget {
  const BottonNavWithAnimation({super.key});

  @override
  State<BottonNavWithAnimation> createState() => _BottonNavWithAnimationState();
}

class _BottonNavWithAnimationState extends State<BottonNavWithAnimation> {
  int selectedNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        height: 72,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: colors.inverseSurface.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withOpacity(0.3),
              offset: const Offset(0, 20),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          children: List.generate(
            navItems.length,
            (index) => Expanded(
              // Para que todos los ítems ocupen espacio igual
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedNavIndex = index;
                  });
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
                        navItems[index].icon,
                        color: selectedNavIndex == index
                            ? colors.inversePrimary
                            : colors.surface,
                        size: 25,
                      ),
                    ), // ícono

                    Opacity(
                      opacity: selectedNavIndex == index ? 1 : 0.5,
                      child: Text(
                        navItems[index].label,
                        style: TextStyle(
                          fontSize: 12,
                          color: selectedNavIndex == index
                              ? colors.inversePrimary
                              : colors.surface,
                          fontWeight: FontWeight.w600, // o el que prefieras
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
              width: 20,
              decoration: BoxDecoration(
                color: colors.inversePrimary,
                borderRadius: BorderRadius.circular(12),
              ),
            )
          : const SizedBox(key: ValueKey('empty'), height: 4, width: 0),
    );
  }
}
