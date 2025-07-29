import 'package:flutter/material.dart';

class LeadingRoundedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double iconSize;
  final double paddingSize;
  final Color iconColor;
  final Color backgroundColor;

  const LeadingRoundedIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = 20,
    this.paddingSize = 6,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: ClipPath(
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              width: iconSize + 16,
              height: iconSize + 16,
              child: Icon(icon, size: iconSize, color: iconColor),
            ),
          ),
        ),
      ),
    );
  }
}
