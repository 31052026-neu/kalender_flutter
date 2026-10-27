import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/provider/provider.dart';

import '../widgets/sternen_hintergrund.dart';
import '../services/ereignis_service.dart';
import '../widgets/ereignis_anzeige.dart';
import '../widgets/datums_anzeige.dart';
import '../functions/KalenderService.dart';
import '../widgets/kalender.dart';
import '../functions/monats_name.dart';

/// Stellt die Hauptseite des Kalenders dar.
class KalenderPage extends ConsumerStatefulWidget {
  const KalenderPage({super.key});

  @override
  ConsumerState<KalenderPage> createState() => _KalenderPageState();
}

/// Verwaltet den lokalen Zustand der KalenderPage.
//  SingleTickerProviderStateMixin liefert Signale für die Animationsframes, sodass Flutter weiß,
//wann der nächste Animationswert berechnet werden soll.
class _KalenderPageState extends ConsumerState<KalenderPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;
  @override
  //Wird einmal beim Erstellen des State-Objekts aufgerufen
  void initState() {
    //Ruft die Initialisierung der übergeordneten Klasse auf
    super.initState();

    _rotationController = AnimationController(
      //Verbindet den Controller mit unserem Ticker
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    //wiederholt die Animation kontinuierlich.
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  final ereignisService = EreignisService();

  bool isLoading = false;

  /// Erstellt die Benutzeroberfläche der Kalenderseite.
  @override
  Widget build(BuildContext context) {
    final calendarNotifier = ref.watch(refCalendarState.notifier);
    final calendarState = ref.watch(refCalendarState);

    return Scaffold(
      body: Stack(
        //Ebene 1: dunkelblauer Farbverlauf
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF030712),
                    Color(0xFF0B2440),
                    Color(0xFF020617),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: SternenHintergrund(
                    rotationsWinkel: _rotationController.value * 2 * pi,
                  ),
                );
              },
            ),
          ),
          /*  SafeArea(
            child: Column(
              children: [
                // Erste Row: Monatsnavigation
                Row(
                  children: [
                    // Linker Pfeil
                    IconButton(
                      onPressed: () {
                        calendarNotifier.moveToPreviousMonth();
                      },
                      icon: const Icon(Icons.chevron_left),
                    ),

                    Text(monatsName(calendarState.dargestelltesDatum)),

                    // Rechter Pfeil
                    IconButton(
                      onPressed: () {
                        calendarNotifier.moveToNextMonth();
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
                Expanded(flex: 1, child: Kalender()),

                const SizedBox(height: 12),

                // Anzeige des ausgewählten Datums
                DatumsAnzeige(
                  datum: calendarState.ausgewaehltesDatum ?? DateTime.now(),
                ),

                // Unterer Bereich: historische Ereignisse
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 100,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : EreignisAnzeige(
                          datum:
                              calendarState.ausgewaehltesDatum ??
                              DateTime.now(),
                        ),
                ),
              ],
            ),
          ), */
        ],
      ),
    );
  }
}
