import 'package:flutter/material.dart';
import 'package:kalender_flutter/logik/services/ereignis_service.dart';
import 'package:kalender_flutter/ui/styles/comic_rahmen.dart';

/// Stellt ein einzelnes historisches Ereignis dar.
class EreignisKarte extends StatelessWidget {
  final Ereignis ereignis;

  const EreignisKarte({super.key, required this.ereignis});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF071B30).withValues(alpha: 0.85),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: erstelleRahmen(Colors.cyanAccent.withValues(alpha: 0.5), 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ereignis.year.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                ereignis.text,
                style: const TextStyle(fontSize: 11, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
