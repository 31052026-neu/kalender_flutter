import 'package:flutter/material.dart';

import '../functions/monats_name.dart';
import '../functions/tage_im_monat.dart';

/// Stellt die Hauptseite des Comic-Kalenders dar.
///
/// Die Seite ist ein [StatefulWidget], da sich später Inhalte
/// wie der angezeigte Monat verändern können.
class KalenderPage extends StatefulWidget {
  const KalenderPage({super.key});

  @override
  State<KalenderPage> createState() => _KalenderPageState();
}

/// Verwaltet den veränderbaren Zustand der [KalenderPage].
class _KalenderPageState extends State<KalenderPage> {
  DateTime dargestelltesDatum = DateTime.now();

  /// Erstellt die Benutzeroberfläche der Kalenderseite.
  ///
  /// Verwendet den aktuellen Zustand der Seite, um die
  /// darzustellenden Inhalte als [Widget] aufzubauen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(monatsName(dargestelltesDatum)),
          Text(tageImMonat(dargestelltesDatum).toString()),
        ],
      ),
    );
  }
}
