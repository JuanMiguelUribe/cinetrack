import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedRatingCircle extends StatefulWidget {
  final double rating; // de 0 a 10
  final double size;
  const AnimatedRatingCircle({super.key, required this.rating, this.size = 40});

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
      if (rating >= 8) return Colors.greenAccent.shade700.withGreen(150);
      if (rating >= 6) return Colors.orangeAccent.shade400.withGreen(140);
      return Colors.redAccent.shade700.withRed(140);
    }
    if (rating >= 8) return Colors.greenAccent.shade400.withGreen(220);
    if (rating >= 6) return Colors.orangeAccent.shade400.withGreen(120);
    return Colors.redAccent.shade400.withRed(200);
  }

  Color getGlowColorText(double rating) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      if (rating >= 8) return Colors.greenAccent;
      if (rating >= 6) return Colors.orangeAccent;
      return Colors.redAccent;
    }
    if (rating >= 8) return Colors.greenAccent.shade400;
    if (rating >= 6) return Colors.orangeAccent;
    return const Color.fromARGB(255, 255, 51, 0);
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: size * 2,
      height: size * 2,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Animated circular progress
              CustomPaint(
                size: const Size(100, 100),
                painter: _StarPainter(
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
                    fontSize: size * 0.6,
                    fontWeight: FontWeight.bold,
                    color: getGlowColorText(widget.rating),
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.9),
                        blurRadius: 20,
                        offset: Offset(0, 0),
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

class _StarPainter extends CustomPainter {
  final double percent;
  final Color color;
  _StarPainter(this.percent, this.color);

  Path _createStarPath(Size size, double innerRadiusRatio) {
    const int numPoints = 5;
    final double outerRadius = size.width / 2;
    final double innerRadius = outerRadius * innerRadiusRatio;
    final center = Offset(size.width / 2, size.height / 2);
    final path = Path();

    for (int i = 0; i < numPoints * 2; i++) {
      final isEven = i % 2 == 0;
      final angle = (i * math.pi) / numPoints - math.pi / 2;
      final radius = isEven ? outerRadius : innerRadius;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = _createStarPath(size, 0.45);
    final bgPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.fill;

    final fillShaderRect = Offset.zero & size;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withOpacity(0.2), color.withOpacity(0.8), color],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(fillShaderRect)
      ..style = PaintingStyle.fill;

    // Draw background star
    canvas.drawPath(path, bgPaint);

    // Clip star to only fill percent of height
    final filledHeight = size.height * (1 - percent);
    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(0, filledHeight, size.width, size.height * percent),
    );
    canvas.drawPath(path, fillPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) => true;
}
