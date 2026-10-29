import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logik/controllers/ereignis_scroll_controller.dart';
import '../../logik/services/ereignis_service.dart';
import 'ereignis_karte.dart';

/// Stellt die Ereignisliste und ihre Ladezustände dar.
class EreignisListe extends StatelessWidget {
  final AsyncValue<List<Ereignis>> ereignisse;
  final EreignisScrollController controller;

  const EreignisListe({
    super.key,
    required this.ereignisse,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ereignisse.when(
      data: (liste) {
        return Listener(
          onPointerDown: (_) => controller.pausieren(),
          onPointerUp: (_) => controller.fortsetzungPlanen(),
          onPointerCancel: (_) => controller.fortsetzungPlanen(),

          child: SingleChildScrollView(
            controller: controller.scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 10),

                ...liste.map((ereignis) => EreignisKarte(ereignis: ereignis)),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },

      error: (error, stackTrace) {
        return Center(
          child: Text(
            'Fehler: $error',
            style: const TextStyle(color: Colors.redAccent),
          ),
        );
      },

      loading: () {
        return const Center(
          child: CircularProgressIndicator(color: Colors.cyanAccent),
        );
      },
    );
  }
}
