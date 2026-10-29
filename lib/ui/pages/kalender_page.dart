import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/logik/functions/KalenderService.dart';
import 'package:kalender_flutter/logik/functions/monats_name.dart';
import 'package:kalender_flutter/logik/provider/provider.dart';
import 'package:kalender_flutter/ui/widgets/datums_anzeige.dart';
import 'package:kalender_flutter/ui/widgets/ereignis_anzeige.dart';
import 'package:kalender_flutter/ui/widgets/kalender.dart';
import 'package:kalender_flutter/ui/widgets/sternen_hintergrund.dart';
import 'package:kalender_flutter/logik/services/sound_service.dart';

/// Stellt die Hauptseite des Kalenders dar.
class KalenderPage extends ConsumerStatefulWidget {
  const KalenderPage({super.key});

  @override
  ConsumerState<KalenderPage> createState() => _KalenderPageState();
}

class _KalenderPageState extends ConsumerState<KalenderPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;
  final SoundService _soundService = SoundService();

  @override
  void initState() {
    super.initState();

    /// Steuert die Rotation der holografischen Kreise.
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
    _soundService.startAmbient();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calendarNotifier = ref.watch(refCalendarState.notifier);
    final calendarState = ref.watch(refCalendarState);

    final ausgewaehltesDatum =
        calendarState.ausgewaehltesDatum ?? DateTime.now();

    return Scaffold(
      body: Stack(
        children: [
          /// Ebene 1: Hintergrund mit Farbverlauf.
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF030712),
                    Color(0xFF0B2440),
                    Color.fromARGB(255, 8, 91, 139),
                  ],
                ),
              ),
            ),
          ),

          /// Ebene 2: Animierte Sterne und Kreise.
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: SternenHintergrund(
                    rotationsWinkel: _rotationController.value * 10,
                  ),
                );
              },
            ),
          ),

          /// Ebene 3: Benutzeroberfläche.
          SafeArea(
            child: Column(
              children: [
                /// OBERER BEREICH
                /// Notes | Kreise | Historische Ereignisse
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// Links: Notes
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                255,
                                8,
                                19,
                                49,
                              ).withValues(alpha: 0.55),
                              border: Border.all(
                                color: Colors.cyanAccent.withValues(
                                  alpha: 0.55,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ToDo's",
                                  style: TextStyle(
                                    color: Colors.cyanAccent,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Noch keine Notizen',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// Mitte: Freier Platz für die Kreise.
                        ///
                        /// Die Kreise werden bereits durch
                        /// SternenHintergrund gezeichnet.
                        const Expanded(flex: 2, child: SizedBox()),

                        /// Rechts: Historische Ereignisse.
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF030712)
                                  .withValues(alpha: 0.55),
                              border: Border.all(
                                color: Colors.cyanAccent.withValues(
                                  alpha: 0.55,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    'HISTORIE',
                                    style: TextStyle(
                                      color: Colors.cyanAccent,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                /// Scrollbarer Ereignisbereich.
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: EreignisAnzeige(
                                      datum: ausgewaehltesDatum,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// UNTERER BEREICH: Kalender
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF030712).withValues(alpha: 0.35),
                    border: Border(
                      top: BorderSide(
                        color: Colors.cyanAccent.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      /// Monatsnavigation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              calendarNotifier.moveToPreviousMonth();
                            },
                            icon: const Icon(
                              Icons.chevron_left,
                              color: Colors.cyanAccent,
                            ),
                          ),

                          Text(
                            monatsName(calendarState.dargestelltesDatum),
                            style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              calendarNotifier.moveToNextMonth();
                            },
                            icon: const Icon(
                              Icons.chevron_right,
                              color: Colors.cyanAccent,
                            ),
                          ),
                        ],
                      ),

                      /// Wochentage
                      Row(
                        children: [
                          ...KalenderService.weekDays.map((tag) {
                            return Expanded(
                              child: Center(
                                child: Text(
                                  tag,
                                  style: const TextStyle(
                                    color: Colors.cyanAccent,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),

                /// Kalenderraster
                Expanded(flex: 1, child: Kalender()),

                /// Anzeige des ausgewählten Datums.
                DatumsAnzeige(datum: ausgewaehltesDatum),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
