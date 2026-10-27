import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

/// Startpunkt der Kalender-Anwendung.
///
/// Startet die Flutter-App und verwendet [KalenderApp]
/// als oberstes Widget.
void main() {
  runApp(ProviderScope(child: const KalenderApp()));
}
