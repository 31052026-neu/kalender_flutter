import 'package:flutter/material.dart';

import '../widgets/ereignis_anzeige.dart';
import '../widgets/datums_anzeige.dart';
import '../functions/KalenderService.dart';
import '../widgets/kalender.dart';
import '../functions/monats_name.dart';

/// Stellt die Hauptseite des Comic-Kalenders dar.
///
/// Die Seite ist ein StatefulWidget, da sich der angezeigte
/// Monat und das ausgewählte Datum verändern können.
class KalenderPage extends StatefulWidget {
  const KalenderPage({super.key});

  @override
  State<KalenderPage> createState() => _KalenderPageState();
}

/// Verwaltet den veränderbaren Zustand der KalenderPage.
class _KalenderPageState extends State<KalenderPage> {
  DateTime dargestelltesDatum = DateTime.now();

  DateTime? ausgewaehltesDatum;

  /// Erstellt die Benutzeroberfläche der Kalenderseite.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Erste Row: Monatsnavigation
            Row(
              children: [
                // Vorheriger Monat
                IconButton(
                  onPressed: () {
                    _changeMonth(dargestelltesDatum.month - 1);
                  },
                  icon: const Icon(Icons.chevron_left),
                ),

                Text(monatsName(dargestelltesDatum)),

                // Nächster Monat
                IconButton(
                  onPressed: () {
                    _changeMonth(dargestelltesDatum.month + 1);
                  },
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),

            // Zweite Row: Wochentage
            Row(
              children: [
                ...KalenderService.weekDays.map((tag) {
                  return Expanded(child: Center(child: Text(tag)));
                }),
              ],
            ),

            // Oberer Bereich: Kalenderraster
            Expanded(
              flex: 1,
              child: Kalender(
                onTap: _changeDay,
                datum: dargestelltesDatum,
                ausgewaehltesDatum: ausgewaehltesDatum,
              ),
            ),

            // Anzeige des ausgewählten Datums
            DatumsAnzeige(datum: ausgewaehltesDatum ?? DateTime.now()),

            // Unterer Bereich: zukünftige historische Ereignisse
            Expanded(
              flex: 1,
              child: EreignisAnzeige(
                datum: ausgewaehltesDatum ?? DateTime.now(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Speichert das vom Benutzer ausgewählte Datum.
  void _changeDay(DateTime newDay) {
    setState(() {
      ausgewaehltesDatum = newDay;
    });
  }

  /// Wechselt den angezeigten Monat.
  void _changeMonth(int newMonth) {
    setState(() {
      dargestelltesDatum = DateTime(dargestelltesDatum.year, newMonth, 1);
    });
  }
}
