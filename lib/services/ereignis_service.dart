import 'package:http/http.dart' as http;

import 'dart:convert';

class EreignisService {
  Future<http.Response> ladeEreignisse(DateTime datum) async {
    String url =
        'https://de.wikipedia.org/api/rest_v1/feed/onthisday/events/${datum.month}/${datum.day}';
    Uri apiUri = Uri.parse(url);
    final antwort = await http.get(apiUri);
    if (antwort.statusCode == 200) {
      final daten = jsonDecode(antwort.body);
      final ereignisse = daten['events'];

      ereignisse.shuffle();

      final zufaelligesErgebnis = ereignisse.take(5).toList();

      return zufaelligesErgebnis;
    } else {
      throw Exception('Ein Fehler ist aufgetreten');
    }
  }
}
