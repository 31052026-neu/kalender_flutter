import 'package:flutter/material.dart';

import 'dart:math';

class StarBackgroundPainter extends CustomPainter {
  StarBackgroundPainter();

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
  }

  //Hintergrund neu zeichnen, wenn sich der Winkel verändert.
  @override
  bool shouldRepaint(covariant StarBackgroundPainter oldDelegate) {
    return oldDelegate != this;
  }
}
