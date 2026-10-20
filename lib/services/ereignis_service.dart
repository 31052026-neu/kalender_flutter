import 'package:http/http.dart';

class EreignisService {
   ladeEreignisse(DateTime datum) async {
    String url =
        'https://de.wikipedia.org/api/rest_v1/feed/onthisday/events/${datum.month}/${datum.day}';
    Uri apiUri = Uri.parse(url);
    await http.get(apiUri);
  }
  return
}
