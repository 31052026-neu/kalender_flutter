import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/logik/painter/star_background_painter.dart';
import 'package:kalender_flutter/logik/provider/provider.dart';
import 'package:kalender_flutter/ui/pages/bottom_area/bottom_area.dart';
import 'package:kalender_flutter/ui/pages/top_area/top_area.dart';

/// Stellt die Hauptseite des Kalenders dar.
class KalenderPage extends ConsumerStatefulWidget {
  const KalenderPage({super.key});

  @override
  ConsumerState<KalenderPage> createState() => _KalenderPageState();
}

class _KalenderPageState extends ConsumerState<KalenderPage> {
  // final SoundService _soundService = SoundService();

  // @override
  // void initState() {
  //   super.initState();

  //   /// Steuert die Rotation der holografischen Kreise.
  //   _soundService.startAmbient();
  // }

  @override
  Widget build(BuildContext context) {
    final calendarState = ref.watch(refCalendarState);
    final ausgewaehltesDatum = calendarState.ausgewaehltesDatum ?? DateTime.now();

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
                  colors: [Color(0xFF030712), Color(0xFF0B2440), Color.fromARGB(255, 8, 91, 139)],
                ),
              ),
            ),
          ),

          /// Ebene 1: Hintergrund mit Farbverlauf.
          Positioned.fill(child: CustomPaint(painter: StarBackgroundPainter())),

          /// Ebene 3: Benutzeroberfläche.
          SafeArea(
            child: Column(
              children: [
                /// OBERER BEREICH
                /// Notes | Kreise | Historische Ereignisse
                Expanded(flex: 1, child: TopArea(ausgewaehltesDatum: ausgewaehltesDatum)),

                /// UNTERER BEREICH: Kalender
                Expanded(flex: 1, child: BottomArea(ausgewaehltesDatum: ausgewaehltesDatum)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
