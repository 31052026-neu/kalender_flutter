import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/functions/KalenderService.dart';
import 'package:kalender_flutter/provider/provider.dart';

import '../styles/comic_rahmen.dart';

class KalenderFeld extends ConsumerWidget {
  /// Das vollständige Datum dieses Kalenderfeldes.
  final DateTime tag;

  const KalenderFeld({super.key, required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(refCalendarState);
    final t = tag;
    final DateTime heutigesDatum = DateTime.now();
    // DateUtils.isSameDay macht, dass nur der Tag wichtig ist und nicht auch die Uhrzeit.
    bool istAusgewaehlt = DateUtils.isSameDay(
      t,
      calendarState.ausgewaehltesDatum,
    );

    // Prüft, ob das Feld zum angezeigten Monat gehört.
    bool istAktuellerMonat =
        t.month == calendarState.dargestelltesDatum.month &&
        t.year == calendarState.dargestelltesDatum.year;
    // Prüft, ob dieses Kalenderfeld den heutigen Tag darstellt.
    bool istHeute =
        t.year == heutigesDatum.year &&
        t.month == heutigesDatum.month &&
        t.day == heutigesDatum.day;

    // Bestimmt die Hintergrundfarbe des Kalenderfeldes.
    Color hintergrundFarbe = istHeute
        ? const Color.fromARGB(255, 54, 244, 86)
        : istAktuellerMonat
        ? Colors.yellow
        : Colors.grey;
    //wenn es Samstag ist und der aktuelle Monat und nicht der heutige Tag ist,
    // dann färbe die Zelle blau.
    if (KalenderService.istSamstag(t) && istAktuellerMonat && !istHeute) {
      hintergrundFarbe = Colors.blue;
    }
    if (KalenderService.istSonntag(t) && istAktuellerMonat && !istHeute) {
      hintergrundFarbe = Colors.red;
    }
    if (istAusgewaehlt == true) {
      hintergrundFarbe = Colors.purpleAccent;
    }

    return InkWell(
      onTap: () {
        ref.read(refCalendarState.notifier).changeDay(tag);
      },
      child: Container(
        decoration: BoxDecoration(
          color: hintergrundFarbe,
          border: erstelleRahmen(Colors.black, 3),
        ),
        child: Center(child: Text(t.day.toString())),
      ),
    );
  }
}
