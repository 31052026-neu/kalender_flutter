import 'package:flutter/material.dart';

import '../controllers/kalenderPage_controller.dart';
import '../services/ereignis_service.dart';
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

  final ereignisService = EreignisService();

  DateTime? ausgewaehltesDatum;
  bool isLoading = false;

  List<dynamic> historischeEreignisse = [];

  final controller = KalenderPageController();

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
                // Linker Pfeil
                IconButton(
                  onPressed: () {
                    controller.vorherigerMonat();
                  },
                  icon: const Icon(Icons.chevron_left),
                ),
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, child) {
                    return Text(monatsName(controller.dargestelltesDatum));
                  },
                ),

                // rechter Pfeil
                IconButton(
                  onPressed: () {
                    controller.naechsterMonat();
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
              child: ListenableBuilder(
                listenable: controller,
                builder: (context, child) {
                  return Kalender(
                    onTap: _changeDay,
                    datum: controller.dargestelltesDatum,
                    ausgewaehltesDatum: ausgewaehltesDatum,
                  );
                },
              ),
            ),
            SizedBox(height: 12),
            // Anzeige des ausgewählten Datums
            DatumsAnzeige(datum: ausgewaehltesDatum ?? DateTime.now()),

            // Unterer Bereich: zukünftige historische Ereignisse
            Expanded(
              child: isLoading
                  ? Center(
                      child: SizedBox(
                        width: 100,
                        height: 20,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : EreignisAnzeige(
                      datum: ausgewaehltesDatum ?? DateTime.now(),
                      ereignisse: historischeEreignisse,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Wechselt den angezeigten Monat.
  void _changeMonth(int newMonth) {
    setState(() {
      dargestelltesDatum = DateTime(dargestelltesDatum.year, newMonth, 1);

      ausgewaehltesDatum = null;
      historischeEreignisse.clear();
    });

    _ladeHistorischeEreignisse(DateTime.now());
  }

  /// Speichert das ausgewählte Datum und lädt dessen Ereignisse.
  void _changeDay(DateTime newDay) async {
    setState(() {
      ausgewaehltesDatum = newDay;
    });

    await _ladeHistorischeEreignisse(newDay);
  }

  /// Lädt die historischen Ereignisse für ein bestimmtes Datum.
  Future<void> _ladeHistorischeEreignisse(DateTime datum) async {
    setState(() {
      isLoading = true;
    });

    try {
      final ereignisse = await ereignisService.ladeEreignisse(datum);

      if (!mounted) return;

      setState(() {
        historischeEreignisse = ereignisse;
      });
    } catch (e) {
      debugPrint('Fehler beim Laden: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
