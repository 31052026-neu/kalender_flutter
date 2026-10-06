import 'package:flutter/material.dart';

import 'pages/kalender_page.dart';

/// Stellt die grundlegende Kalender-Anwendung dar.
///
/// [KalenderApp] legt die allgemeinen Einstellungen der App fest,
/// beispielsweise das Theme und die Startseite.
class KalenderApp extends StatelessWidget {
  const KalenderApp({super.key});

  /// Erstellt die grundlegende Struktur der Anwendung.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comic Kalender',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: const KalenderPage(),
    );
  }
}
