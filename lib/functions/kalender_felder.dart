import 'erster_wochentag_im_monat.dart';
import 'tage_im_monat.dart';

/// Erstellt die Felder für den Kalender des angegebenen Monats.
List<String> kalenderFelder(DateTime datum) {
  List<String> felder = [];

  for (int i = 0; i < ersterWochenTagImMonat(datum) - 1; i++) {
    felder.add('');
  }

  for (int i = 1; i <= tageImMonat(datum); i++) {
    felder.add(i.toString());
  }
  return felder;
}
