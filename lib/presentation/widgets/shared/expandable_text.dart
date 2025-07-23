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

    return AnimatedSize(
      duration: const Duration(milliseconds: 800),
      curve: Curves.decelerate,
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: widget.style ?? DefaultTextStyle.of(context).style,
          children: [
            TextSpan(text: visibleText),
            if (!showAll) const TextSpan(text: '... '),
            TextSpan(
              text: showAll ? ' Ver menos' : ' Ver más',
              style:
                  widget.linkStyle ??
                  TextStyle(
                    color: colors.brightness == Brightness.dark
                        ? Colors.blueAccent.shade200
                        : Colors.blueAccent.shade700,
                    fontWeight: FontWeight.w600,
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
