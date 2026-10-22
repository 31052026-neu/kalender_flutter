import 'package:flutter/material.dart';
import 'package:kalender_flutter/functions/KalenderService.dart';
import 'package:kalender_flutter/styles/comic_rahmen.dart';

/// Zeigt historische Ereignisse zum ausgewählten Datum an.
class EreignisAnzeige extends StatelessWidget {
  final DateTime datum;
  final List<dynamic> ereignisse;

  const EreignisAnzeige({
    super.key,
    required this.datum,
    required this.ereignisse,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          //spread Operator(...)
          ...ereignisse.map((ereignis) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: erstelleRahmen(Colors.black, 3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ereignis['year'].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(ereignis['text'], style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
