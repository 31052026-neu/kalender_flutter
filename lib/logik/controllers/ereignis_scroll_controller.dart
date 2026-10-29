import 'dart:async';

import 'package:flutter/material.dart';

/// Verwaltet das automatische Scrollen historischer Ereignisse.
class EreignisScrollController {
  final ScrollController scrollController = ScrollController();

  Timer? _scrollTimer;
  Timer? _pauseTimer;

  bool _nachUnten = true;
  bool _automatikPausiert = false;

  /// Geschwindigkeit in Pixel pro Sekunde.
  static const double _geschwindigkeit = 12.0;

  /// Startet das automatische Scrollen.
  void start() {
    _scrollTimer?.cancel();

    const interval = Duration(milliseconds: 30);

    _scrollTimer = Timer.periodic(interval, (_) {
      if (_automatikPausiert || !scrollController.hasClients) {
        return;
      }

      final position = scrollController.position;

      if (position.maxScrollExtent <= position.minScrollExtent) {
        return;
      }

      final schritt = _geschwindigkeit * interval.inMilliseconds / 1000;

      final aktuellePosition = scrollController.offset;

      double neuePosition;

      if (_nachUnten) {
        neuePosition = aktuellePosition + schritt;

        if (neuePosition >= position.maxScrollExtent) {
          neuePosition = position.maxScrollExtent;
          _nachUnten = false;
        }
      } else {
        neuePosition = aktuellePosition - schritt;

        if (neuePosition <= position.minScrollExtent) {
          neuePosition = position.minScrollExtent;
          _nachUnten = true;
        }
      }

      scrollController.jumpTo(neuePosition);
    });
  }

  /// Pausiert die automatische Bewegung.
  void pausieren() {
    _pauseTimer?.cancel();
    _automatikPausiert = true;
  }

  /// Setzt die Automatik nach fünf Sekunden fort.
  void fortsetzungPlanen() {
    _pauseTimer?.cancel();

    _pauseTimer = Timer(const Duration(seconds: 0), () {
      _automatikPausiert = false;

      if (!scrollController.hasClients) return;

      final position = scrollController.position;

      if (scrollController.offset >= position.maxScrollExtent) {
        _nachUnten = false;
      } else if (scrollController.offset <= position.minScrollExtent) {
        _nachUnten = true;
      }
    });
  }

  /// Setzt die Liste bei einem Datumswechsel zurück.
  void zuruecksetzen() {
    _pauseTimer?.cancel();
    _automatikPausiert = false;
    _nachUnten = true;

    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    }
  }

  /// Gibt alle verwendeten Ressourcen frei.
  void dispose() {
    _scrollTimer?.cancel();
    _pauseTimer?.cancel();
    scrollController.dispose();
  }
}
