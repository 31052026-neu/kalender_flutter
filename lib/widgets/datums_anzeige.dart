import 'package:flutter/material.dart';

import '../styles/comic_rahmen.dart';

import 'package:kalender_flutter/functions/KalenderService.dart';

class DatumsAnzeige extends StatelessWidget {
  /// Das Datum, das angezeigt werden soll.
  final DateTime datum;

  const DatumsAnzeige({super.key, required this.datum});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purpleAccent,
        borderRadius: BorderRadius.circular(12),
        border: erstelleRahmen(Colors.black, 3),
      ),
      padding: EdgeInsets.all(12),
      child: Text(KalenderService.formatiereDatum(datum)),
    );
  }
}
