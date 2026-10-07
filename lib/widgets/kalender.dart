import 'package:flutter/material.dart';
import 'package:kalender_flutter/functions/kalender_felder.dart';

class Kalender extends StatelessWidget {
  final DateTime datum;

  /// Kontstruktor mit dem benannten Parameter [datum].
  Kalender({required this.datum});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: kalenderFelder(datum).length,
      itemBuilder: (context, index) {
        return Text(kalenderFelder(datum)[index]);
      },
    );
  }
}
