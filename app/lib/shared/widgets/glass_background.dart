import 'dart:math';

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class GlassBackground extends StatelessWidget {
  const GlassBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppGlassColors.gradientStart,
                AppGlassColors.gradientEnd,
              ],
            ),
          ),
        ),
        const Positioned.fill(child: _NoiseLayer()),
        child,
      ],
    );
  }
}

class _NoiseLayer extends StatelessWidget {
  const _NoiseLayer();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NoisePainter(),
    );
  }
}

class _NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x0D0F172A);
    final random = Random(42);

    for (var i = 0; i < 1200; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      canvas.drawRect(Rect.fromLTWH(dx, dy, 1, 1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
