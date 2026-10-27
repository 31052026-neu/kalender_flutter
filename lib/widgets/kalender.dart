import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/functions/kalender_felder.dart';
import 'package:kalender_flutter/provider/provider.dart';

import 'kalender_feld.dart';

class Kalender extends ConsumerStatefulWidget {
  const Kalender({super.key});

  @override
  ConsumerState<Kalender> createState() => _KalenderState();
}

/// Stellt die Tagesfelder eines Monats als Kalender-Raster dar.
class _KalenderState extends ConsumerState<Kalender> {
  @override
  Widget build(BuildContext context) {
    final calendarState = ref.watch(refCalendarState);
    final tagesFelder = kalenderFelder(calendarState.dargestelltesDatum);
    final anzahlWochen = (tagesFelder.length / 7).ceil();
    final int anzahlAbstaende = anzahlWochen - 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Besagt, dass genau 4px Abstand zwischen den Spalten eingehalten werden sollen.
        const double abstand = 4.0;

        final double gesamtAbstand = anzahlAbstaende * abstand;
        final hoeheProWoche =
            ((constraints.maxHeight - gesamtAbstand) / anzahlWochen).clamp(
              0.0,
              double.infinity,
            );

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
