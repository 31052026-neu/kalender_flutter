import 'package:flutter/material.dart';

/// Erstellt einen Rahmen auf allen vier Seiten.
Border erstelleRahmen(Color farbe, double breite) {
  return Border.all(color: farbe, width: breite);
}
