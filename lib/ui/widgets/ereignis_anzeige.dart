import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/logik/provider/provider.dart';

import 'package:kalender_flutter/logik/controllers/ereignis_scroll_controller.dart';

import 'ereignis_liste.dart';

/// Verwaltet die Ereignisdaten und den ScrollController.
class EreignisAnzeige extends ConsumerStatefulWidget {
  final DateTime datum;

  const EreignisAnzeige({super.key, required this.datum});

  @override
  ConsumerState<EreignisAnzeige> createState() => _EreignisAnzeigeState();
}

class _EreignisAnzeigeState extends ConsumerState<EreignisAnzeige> {
  /// Verwaltet die automatische Scrollbewegung.
  final EreignisScrollController _controller = EreignisScrollController();

  @override
  void initState() {
    super.initState();

    /// Startet die Automatik nach dem ersten Frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.start();
      }
    });
  }

  @override
  void didUpdateWidget(covariant EreignisAnzeige oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Setzt bei einem Datumswechsel die Scrollposition zurück.
    if (!DateUtils.isSameDay(oldWidget.datum, widget.datum)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.zuruecksetzen();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Holt die historischen Ereignisse über Riverpod.
    final ereignisse = ref.watch(refHistorischeEreignisse(widget.datum));

    /// Übergibt Daten und Controller an die UI.
    return EreignisListe(ereignisse: ereignisse, controller: _controller);
  }
}
