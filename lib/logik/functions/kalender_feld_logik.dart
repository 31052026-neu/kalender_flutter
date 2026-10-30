import 'package:flutter/material.dart';
import 'package:kalender_flutter/logik/functions/kalender_service.dart';

/// Enthält die berechneten Eigenschaften eines Kalenderfeldes.
class KalenderFeldLogik {
  final DateTime tag;
  final DateTime dargestelltesDatum;
  final DateTime? ausgewaehltesDatum;

  KalenderFeldLogik({required this.tag, required this.dargestelltesDatum, required this.ausgewaehltesDatum});

  /// Prüft, ob der Tag ausgewählt ist.
  bool get istAusgewaehlt => DateUtils.isSameDay(tag, ausgewaehltesDatum);

  /// Prüft, ob der Tag zum angezeigten Monat gehört.
  bool get istAktuellerMonat => tag.month == dargestelltesDatum.month && tag.year == dargestelltesDatum.year;

  /// Prüft, ob der Tag heute ist.
  bool get istHeute => DateUtils.isSameDay(tag, DateTime.now());

  /// Prüft, ob der Tag ein Samstag ist.
  bool get istSamstag => KalenderService.istSamstag(tag);

  /// Prüft, ob der Tag ein Sonntag ist.
  bool get istSonntag => KalenderService.istSonntag(tag);

  /// Ermittelt die Hintergrundfarbe des Kalenderfeldes.
  Color get hintergrundFarbe {
    Color farbe = istAktuellerMonat
        ? const Color(0xFF071B30).withValues(alpha: 0.7)
        : const Color(0xFF030712).withValues(alpha: 0.3);

    if (istSamstag && istAktuellerMonat && !istHeute) {
      farbe = const Color.fromARGB(123, 33, 149, 243);
    }

    if (istSonntag && istAktuellerMonat && !istHeute) {
      farbe = const Color.fromARGB(123, 244, 67, 54);
    }

    if (istAusgewaehlt) {
      farbe = const Color.fromARGB(123, 8, 206, 18);
    }

    return farbe;
  }
}
