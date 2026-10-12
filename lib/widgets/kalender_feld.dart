import 'package:flutter/material.dart';

/// Stellt ein einzelnes Tagesfeld des Kalenders dar.
class KalenderFeld extends StatelessWidget {
  //speichert den Text, den das Kalenderfeld anzeigen soll.
  final String tag;
  final DateTime datum;

  const KalenderFeld({super.key, required this.tag, required this.datum});

  @override
  Widget build(BuildContext context) {
    final DateTime heutigesDatum = DateTime.now();

    bool istHeute = tag == heutigesDatum.day.toString();

    bool istGleicherMonat = datum.month == heutigesDatum.month;

    bool istGleichesJahr = datum.year == heutigesDatum.year;

    bool istTatsaechlichHeute = istHeute && istGleicherMonat && istGleichesJahr;
    //tenären Operator implementiert.
    Color hintergrundFarbe = istTatsaechlichHeute ? Colors.red : Colors.yellow;
    return Container(
      decoration: BoxDecoration(
        color: hintergrundFarbe,
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Center(child: Text(tag)),
    );
  }
}
