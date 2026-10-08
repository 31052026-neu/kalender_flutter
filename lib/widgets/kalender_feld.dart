import 'package:flutter/material.dart';

/// Stellt ein einzelnes Tagesfeld des Kalenders dar.
class KalenderFeld extends StatelessWidget {
  //speichert den Text, den das Kalenderfeld anzeigen soll.
  final String tag;

  const KalenderFeld({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Center(child: Text(tag)),
    );
  }
}
