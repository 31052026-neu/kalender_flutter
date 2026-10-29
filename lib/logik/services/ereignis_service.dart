import 'package:http/http.dart' as http;

import 'dart:convert';

class Ereignis {
  final int year;
  final String text;

  const Ereignis({required this.year, required this.text});

  factory Ereignis.fromJson(Map<String, dynamic> json) {
    return Ereignis(year: json['year'] as int, text: json['text'] as String);
  }

  @override
  String toString() => 'Ereignis(year: $year, text: $text)';
}

class EreignisService {
  Future<List<Ereignis>> ladeEreignisse(DateTime datum) async {
    String url =
        'https://de.wikipedia.org/api/rest_v1/feed/onthisday/events/${datum.month}/${datum.day}';
    Uri apiUri = Uri.parse(url);
    final antwort = await http.get(apiUri);
    if (antwort.statusCode == 200) {
      final daten = jsonDecode(antwort.body);
      final ereignisse = (daten['events'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      ereignisse.shuffle();

      final zufaelligesErgebnis = ereignisse
          .take(5)
          .map((e) => Ereignis.fromJson(e))
          .toList();

      return zufaelligesErgebnis;
    } else {
      throw Exception('Ein Fehler ist aufgetreten');
    }
  }
}
