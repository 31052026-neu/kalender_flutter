import 'package:flutter/material.dart';
import 'package:kalender_flutter/functions/KalenderService.dart';

class KalenderFeld extends StatelessWidget {
  final void Function(int) onTap;

  /// Das vollständige Datum dieses Kalenderfeldes.
  final DateTime tag;

  /// Der aktuell angezeigte Monat.
  final DateTime heute;

  const KalenderFeld({
    required this.onTap,
    required this.tag,
    required this.heute,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = tag;
    // Prüft, ob das Feld zum angezeigten Monat gehört.
    bool istAktuellerMonat = t.month == heute.month && t.year == heute.year;
    // Prüft, ob dieses Kalenderfeld den heutigen Tag darstellt.
    bool istHeute = istAktuellerMonat && t.day == heute.day;

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

    return InkWell(
      onTap: () {
        onTap(tag.day);
      },
      child: Container(
        decoration: BoxDecoration(
          color: hintergrundFarbe,
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        child: Center(child: Text(t.day.toString())),
      ),
    );
  }
}
