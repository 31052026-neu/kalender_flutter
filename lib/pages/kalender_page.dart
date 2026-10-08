import 'package:flutter/material.dart';

import '../functions/wochen_tage.dart';
import '../widgets/kalender.dart';
import '../functions/monats_name.dart';

/// Stellt die Hauptseite des Comic-Kalenders dar.
///
/// Die Seite ist ein [StatefulWidget], da sich später Inhalte
/// wie der angezeigte Monat verändern können.
class KalenderPage extends StatefulWidget {
  const KalenderPage({super.key});

  @override
  State<KalenderPage> createState() => _KalenderPageState();
}

/// Verwaltet den veränderbaren Zustand der [KalenderPage].
class _KalenderPageState extends State<KalenderPage> {
  DateTime dargestelltesDatum = DateTime.now();

  /// Erstellt die Benutzeroberfläche der Kalenderseite.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(monatsName(dargestelltesDatum)),

            Row(
              children: [
                // Der Spread-Operator("...") fügt die erzeugten Widgets
                // einzeln in die children-Liste ein.
                ...wochenTage().map((tag) {
                  return Expanded(child: Center(child: Text(tag)));
                }),
              ],
            ),
            Expanded(child: Kalender(datum: dargestelltesDatum)),
          ],
        ),
      ),
    );
  }
}
