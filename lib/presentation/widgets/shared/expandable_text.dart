import 'package:movieflex/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int wordLimit;
  final TextStyle? style;
  final TextStyle? linkStyle;

  const ExpandableText({
    super.key,
    required this.text,
    this.wordLimit = 30,
    this.style,
    this.linkStyle,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final words = widget.text.split(' ');
    final showAll = isExpanded || words.length <= widget.wordLimit;

    final visibleText = showAll
        ? widget.text
        : words.take(widget.wordLimit).join(' ');
    final hasLink = words.length > widget.wordLimit;

    return AnimatedSize(
      duration: const Duration(milliseconds: 800),
      curve: Curves.decelerate,
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: widget.style ?? DefaultTextStyle.of(context).style,
          children: [
            TextSpan(text: visibleText),
            if (hasLink && !showAll) const TextSpan(text: '...  '),
            if (hasLink)
              TextSpan(
                text: isExpanded
                    ? "  ${AppLocalizations.of(context)!.showLess}"
                    : AppLocalizations.of(context)!.showMore,
                style:
                    widget.linkStyle ??
                    TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() => isExpanded = !isExpanded);
                  },
              ),
          ],
        ),
      ),
    );
  }
}
