import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/logik/functions/kalender_feld_logik.dart';
import 'package:kalender_flutter/logik/provider/provider.dart';

import 'kalender_feld_ui.dart';

/// Verbindet die Kalenderlogik mit der Benutzeroberfläche.
class KalenderFeld extends ConsumerWidget {
  final DateTime tag;

  const KalenderFeld({super.key, required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Holt den aktuellen Kalenderzustand.
    final calendarState = ref.watch(refCalendarState);

    /// Berechnet die Eigenschaften des Tages.
    final logik = KalenderFeldLogik(
      tag: tag,
      dargestelltesDatum: calendarState.dargestelltesDatum,
      ausgewaehltesDatum: calendarState.ausgewaehltesDatum,
    );

    /// Übergibt die Daten an die UI.
    return KalenderFeldUI(
      tag: tag.day,
      hintergrundFarbe: logik.hintergrundFarbe,
      onTap: () {
        ref.read(refCalendarState.notifier).changeDay(tag);
      },
    );
  }
}
