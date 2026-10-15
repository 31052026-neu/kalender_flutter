import 'package:flutter/material.dart';
import 'package:kalender_flutter/functions/KalenderService.dart';
import 'package:kalender_flutter/styles/comic_rahmen.dart';

/// Zeigt historische Ereignisse zum ausgewählten Datum an.
class EreignisAnzeige extends StatelessWidget {
  final DateTime datum;

  const EreignisAnzeige({super.key, required this.datum});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: erstelleRahmen(Colors.black, 3),
                    ),
                    padding: EdgeInsets.all(12),
                  ),
                  Text(
                    'Ereignis: 1',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Ereignis: 1A'),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: erstelleRahmen(Colors.black, 3),
                    ),
                    padding: EdgeInsets.all(12),
                  ),
                  Text(
                    'Ereignis: 2',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Ereignis: 2A'),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: erstelleRahmen(Colors.black, 3),
                    ),
                    padding: EdgeInsets.all(12),
                  ),
                  Text(
                    'Ereignis: 3',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Ereignis: 3A'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
