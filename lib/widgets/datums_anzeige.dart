import 'package:flutter/material.dart';
import 'package:kalender_flutter/functions/KalenderService.dart';

class DatumsAnzeige extends StatelessWidget {
  /// Das Datum, das angezeigt werden soll.
  final DateTime datum;

  const DatumsAnzeige({super.key, required this.datum});

  @override
  Widget build(BuildContext context) {
    return Text(KalenderService.formatiereDatum(datum));
  }
}
