import 'package:flutter/material.dart';

import 'dart:math';

class HolographicCirclePainter extends CustomPainter {
  final double rotationAngle;

  const HolographicCirclePainter({required this.rotationAngle});
  @override
  void paint(Canvas canvas, Size size) {
    /// Zeichnet die vollständigen holografischen Ringe.
    final Paint ringFarbe = Paint()
      ..color = const Color.fromARGB(220, 3, 120, 175)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    /// Zeichnet die helleren, leuchtenden Ringsegmente.
    final Paint segmentFarbe = Paint()
      ..color = const Color.fromARGB(255, 8, 106, 197)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    /// Mittelpunkt unserer holografischen Ringe.
    final Offset mittelpunkt = Offset(size.width / 2, size.height / 4.5);

    /// Unterschiedliche Ringdurchmesser.
    final List<double> radien = [40, 65, 90, 110];

    /// Zeichnet vier vollständige Ringe mit Ringsegmenten.
    for (int i = 0; i < radien.length; i++) {
      final double radius = radien[i];
      double aktuellerWinkel = rotationAngle;

      switch (radien[i]) {
        case 40:
          aktuellerWinkel = rotationAngle * 4;
          break;
        case 65:
          aktuellerWinkel = rotationAngle * -4;
          break;
        case 90:
          aktuellerWinkel = rotationAngle * 1;
          break;
        case 110:
          aktuellerWinkel = rotationAngle * -2;
          break;
      }

      /// Vollständiger Ring.
      canvas.drawCircle(mittelpunkt, radius, ringFarbe);

      /// Rechteck, das den Kreisbogen begrenzt.
      final Rect ringRechteck = Rect.fromCircle(center: mittelpunkt, radius: radius);

      /// Leuchtendes Ringsegment:
      /// Start bei 0 Grad (rechts).
      /// Verlauf über 90 Grad im Uhrzeigersinn.
      canvas.drawArc(
        //größe und Position des Kreises
        ringRechteck,
        //wo das Segment beginnt
        aktuellerWinkel,
        //Wie lang das sich drehende Segment des Kreises ist.
        pi / 2,
        false,
        segmentFarbe,
      );
    }
  }

  @override
  bool shouldRepaint(covariant HolographicCirclePainter oldDelegate) {
    return oldDelegate.rotationAngle != rotationAngle;
  }
}
