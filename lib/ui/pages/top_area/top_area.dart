import 'package:flutter/material.dart';
import 'package:kalender_flutter/ui/pages/top_area/_historische_ereignisse/_ereignisse_widget.dart';
import 'package:kalender_flutter/ui/pages/top_area/_rotating_circle/_rotating_circle.dart';
import 'package:kalender_flutter/ui/pages/top_area/_todo/_todo_widget.dart';

class TopArea extends StatelessWidget {
  final DateTime ausgewaehltesDatum;

  const TopArea({required this.ausgewaehltesDatum, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Links: Notes
          Expanded(flex: 1, child: ToDoWidget()),

          /// Mitte: Freier Platz für die Kreise.
          ///
          /// Die Kreise werden bereits durch
          /// SternenHintergrund gezeichnet.
          const Expanded(
            flex: 2,
            child: Center(
              child:
                  /// Ebene 2: Animierte Sterne und Kreise.
                  Positioned.fill(child: RotatingCircle()),
            ),
          ),

          /// Rechts: Historische Ereignisse.
          Expanded(flex: 1, child: HistorischeEreignisseWidget(ausgewaehltesDatum: ausgewaehltesDatum)),
        ],
      ),
    );
  }
}
