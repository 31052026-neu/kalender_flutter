import 'package:flutter/material.dart';

/// Zeigt historische Ereignisse zum ausgewählten Datum an.
class EreignisAnzeige extends StatelessWidget {
  final DateTime datum;

  const EreignisAnzeige({super.key, required this.datum});

  @override
  Widget build(BuildContext context) {
    return Text('Ereignisse:');
  }
}
