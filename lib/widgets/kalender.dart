import 'package:flutter/material.dart';
import 'package:kalender_flutter/functions/kalender_felder.dart';

import 'kalender_feld.dart';

/// Stellt die Tagesfelder eines Monats als Kalender-Raster dar.
class Kalender extends StatelessWidget {
  final DateTime datum;

  const Kalender({super.key, required this.datum});
  @override
  Widget build(BuildContext context) {
    final tagesFelder = kalenderFelder(datum);
    final anzahlWochen = (tagesFelder.length / 7).ceil();
    final int anzahlAbstaende = anzahlWochen - 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Besagt, dass genau 4px Abstand zwischen den Spalten eingehalten werden sollen.
        const double abstand = 4.0;

        final double gesamtAbstand = anzahlAbstaende * abstand;
        final hoeheProWoche =
            (constraints.maxHeight - gesamtAbstand) / anzahlWochen;

        return GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: hoeheProWoche,
            crossAxisSpacing: abstand,
            mainAxisSpacing: abstand,
          ),
          itemCount: tagesFelder.length,
          itemBuilder: (context, index) {
            return KalenderFeld(tag: tagesFelder[index]);
          },
        );
      },
    );
  }
}
