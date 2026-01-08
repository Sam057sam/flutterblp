import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class GlassSurface extends StatelessWidget {
  const GlassSurface({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.blurSigma,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double? blurSigma;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final sigma = blurSigma ?? (width < 700 ? 8 : 16);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: (color ?? AppGlassColors.glassTint),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: AppGlassColors.glassBorder, width: 1),
            boxShadow: const [
              BoxShadow(
                color: AppGlassColors.glassShadow,
                blurRadius: 24,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
