import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedRatingCircle extends StatefulWidget {
  final double rating; // de 0 a 10
  const AnimatedRatingCircle({super.key, required this.rating});

  @override
  State<AnimatedRatingCircle> createState() => _AnimatedRatingCircleState();
}

class _AnimatedRatingCircleState extends State<AnimatedRatingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double percent;

  @override
  void initState() {
    super.initState();
    percent = widget.rating / 10;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _animation = Tween<double>(
      begin: 0,
      end: percent,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getGlowColor(double rating) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      if (rating >= 8) return Colors.greenAccent.shade700;
      if (rating >= 6) return Colors.deepOrange.shade700;
      return Colors.redAccent.shade700;
    }
    if (rating >= 8) return Colors.greenAccent.shade400;
    if (rating >= 6) return Colors.orangeAccent;
    return Colors.redAccent.shade200;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.2,
      height: size.width * 0.2,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Glow Circle Background
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: getGlowColor(widget.rating).withOpacity(0.05),
                    ),
                  ],
                ),
              ),
              // Animated circular progress
              CustomPaint(
                size: const Size(100, 100),
                painter: _CirclePainter(
                  _animation.value,
                  getGlowColor(widget.rating),
                ),
              ),
              // Floating Rating Text
              Transform.translate(
                offset: Offset(0, -5 * math.sin(_controller.value * math.pi)),
                child: Text(
                  '${(widget.rating).toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: getGlowColor(widget.rating),
                    shadows: [
                      Shadow(
                        color: getGlowColor(widget.rating).withOpacity(0.3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double percent;
  final Color color;
  _CirclePainter(this.percent, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 8.0;
    final rect = Offset.zero & size;
    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * percent;

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade800
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final foregroundPaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withOpacity(0.8), color],
      ).createShader(rect)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 2 - strokeWidth / 2,
      backgroundPaint,
    );
    canvas.drawArc(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => true;
}
