import 'package:kalender_flutter/logik/functions/tage_Im_Monat.dart';

import 'erster_wochentag_im_monat.dart';

/// Erstellt die Felder für den Kalender des angegebenen Monats.
List<DateTime> kalenderFelder(DateTime datum) {
  List<DateTime> felder = [];

  // Anzahl der Tage im Vormonat.
  int tageImVormonat = tageImMonat(DateTime(datum.year, datum.month - 1, 1));

  // Anzahl der benötigten Felder vor Monatsbeginn.
  int anzahlFelderVormonat = ersterWochenTagImMonat(datum) - 1;

  // Erster anzuzeigender Tag des Vormonats.
  int ersterTagVormonat = tageImVormonat - anzahlFelderVormonat + 1;

  // Letzte Tage des Vormonats hinzufügen.
  for (int i = 0; i < anzahlFelderVormonat; i++) {
    felder.add(DateTime(datum.year, datum.month - 1, ersterTagVormonat + i));
  }

  // Tage des aktuellen Monats hinzufügen.
  for (int i = 1; i <= tageImMonat(datum); i++) {
    felder.add(DateTime(datum.year, datum.month, i));
  }

  // Bereits belegte Felder der letzten Woche.
  int restlicheFelder = felder.length % 7;

  // Fehlende Felder bis zum Ende der Woche.
  int fehlendeFelder = restlicheFelder == 0 ? 0 : 7 - restlicheFelder;

  // Erste Tage des Folgemonats hinzufügen.
  for (int i = 1; i < fehlendeFelder + 1; i++) {
    felder.add(DateTime(datum.year, datum.month + 1, i));
  }

  return felder;
}
