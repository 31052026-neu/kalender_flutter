import 'package:flutter/material.dart';
import 'package:kalender_flutter/ui/pages/top_area/_historische_ereignisse/ereignis_anzeige.dart';

class HistorischeEreignisseWidget extends StatelessWidget {
  final DateTime ausgewaehltesDatum;

  const HistorischeEreignisseWidget({required this.ausgewaehltesDatum, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF030712).withValues(alpha: 0.55),
        border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.55)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              'HISTORIE',
              style: TextStyle(color: Colors.cyanAccent, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),

          /// Scrollbarer Ereignisbereich.
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: EreignisAnzeige(datum: ausgewaehltesDatum),
            ),
          ),
        ],
      ),
    );
  }
}
