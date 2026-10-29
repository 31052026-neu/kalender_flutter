import 'package:flutter/material.dart';
import 'package:kalender_flutter/logik/functions/KalenderService.dart';

import 'package:kalender_flutter/ui/styles/comic_rahmen.dart';

class DatumsAnzeige extends StatelessWidget {
  /// Das Datum, das angezeigt werden soll.
  final DateTime datum;

  const DatumsAnzeige({super.key, required this.datum});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(106, 10, 85, 155),
        borderRadius: BorderRadius.circular(12),
        border: erstelleRahmen(Colors.black, 3),
      ),
      padding: EdgeInsets.all(12),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ausgewähltes Datum',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              KalenderService.formatiereDatum(datum),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
