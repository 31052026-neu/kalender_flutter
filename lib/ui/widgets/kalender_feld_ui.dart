import 'package:flutter/material.dart';

import '../styles/comic_rahmen.dart';

/// Stellt das Design eines einzelnen Kalenderfeldes dar.
class KalenderFeldUI extends StatelessWidget {
  final int tag;
  final Color hintergrundFarbe;
  final VoidCallback onTap;

  const KalenderFeldUI({
    super.key,
    required this.tag,
    required this.hintergrundFarbe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: hintergrundFarbe,
          border: erstelleRahmen(const Color.fromARGB(34, 16, 131, 197), 3),
        ),
        child: Center(
          child: Text(
            tag.toString(),
            style: const TextStyle(
              color: Color(0xFF00E5FF),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Color(0xFF00E5FF), blurRadius: 12)],
            ),
          ),
        ),
      ),
    );
  }
}
