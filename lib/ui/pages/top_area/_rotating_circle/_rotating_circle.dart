import 'package:flutter/material.dart';
import 'package:kalender_flutter/logik/painter/holographic_circle_painter.dart';

class RotatingCircle extends StatefulWidget {
  const new({super.key});

  @override
  State<RotatingCircle> createState() => _RotatingCircleState();
}

class _RotatingCircleState extends State<RotatingCircle> with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    /// Steuert die Rotation der holografischen Kreise.
    _rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 40))..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return CustomPaint(painter: HolographicCirclePainter(rotationAngle: _rotationController.value * 10));
      },
    );
  }
}
