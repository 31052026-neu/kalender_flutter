import 'package:flutter/material.dart';

import 'dart:math';

class SternenHintergrund extends CustomPainter {
  final double rotationsWinkel;

  SternenHintergrund({required this.rotationsWinkel});

  @override
  void paint(Canvas canvas, Size size) {
    /// Zufallsgenerator mit festem Seed (startpunkt).
    /// Dadurch bleiben die Sternpositionen reproduzierbar.
    final random = Random(42);

    /// Zeichnet den blauen Lichtschein der Sterne.
    final Paint sternFarbe = Paint()
      ..color = Colors.cyan
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    /// Zeichnet den weißen Kern der Sterne.
    final Paint sternKern = Paint()..color = Colors.white;

    /// Zeichnet die vollständigen holografischen Ringe.
    final Paint ringFarbe = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    /// Zeichnet die helleren, leuchtenden Ringsegmente.
    final Paint segmentFarbe = Paint()
      ..color = Colors.cyanAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    /// Zeichnet 100 Sterne an zufälligen Positionen.
    for (int i = 0; i < 100; ++i) {
      final double x = random.nextDouble() * size.width;
      final double y = random.nextDouble() * size.height;

      /// Zufälliger Radius zwischen 1 und knapp unter 3.
      final double radius = random.nextDouble() * 2 + 1;

      final Offset position = Offset(x, y);

      /// Blauer Lichtschein.
      canvas.drawCircle(position, radius, sternFarbe);

      /// Weißer Sternkern.
      canvas.drawCircle(position, radius / 2, sternKern);
    }

    /// Mittelpunkt unserer holografischen Ringe.
    final Offset mittelpunkt = Offset(size.width / 2, size.height / 2);

    /// Unterschiedliche Ringgrößen.
    final List<double> radien = [40, 65, 90, 110];

    /// Zeichnet vier vollständige Ringe mit Ringsegmenten.
    for (int i = 0; i < radien.length; i++) {
      final double radius = radien[i];

      /// Vollständiger Ring.
      canvas.drawCircle(mittelpunkt, radius, ringFarbe);

      /// Rechteck, das den Kreisbogen begrenzt.
      final Rect ringRechteck = Rect.fromCircle(
        center: mittelpunkt,
        radius: radius,
      );

      /// Leuchtendes Ringsegment:
      /// Start bei 0 Grad (rechts).
      /// Verlauf über 90 Grad im Uhrzeigersinn.
      canvas.drawArc(
        //größe und Position des Kreises
        ringRechteck,
        //wo das Segment beginnt
        rotationsWinkel,
        //Wie lang das sich drehende Segment des Kreises ist.
        pi / 2,
        false,
        segmentFarbe,
      );
    }
  }

  //Hintergrund neu zeichnen, wenn sich der Winkel verändert.
  @override
  bool shouldRepaint(covariant SternenHintergrund oldDelegate) {
    return oldDelegate.rotationsWinkel != rotationsWinkel;
  }
}
