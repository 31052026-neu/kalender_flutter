class KalenderService {
  static List<String> get weekDays => ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

  /// Erstellt die Felder für den Kalender des angegebenen Monats.
  static List<DateTime> getKalenderFelder(DateTime datum) {
    List<DateTime> felder = [];

    // Anzahl der Tage im Vormonat.
    int tageImVormonat = _tageImMonat(DateTime(datum.year, datum.month - 1, 1));

    // Anzahl der benötigten Felder vor Monatsbeginn.
    int anzahlFelderVormonat = _ersterWochenTagImMonat(datum) - 1;

    // Erster anzuzeigender Tag des Vormonats.
    int ersterTagVormonat = tageImVormonat - anzahlFelderVormonat + 1;

    // Letzte Tage des Vormonats hinzufügen.
    for (int i = 0; i < anzahlFelderVormonat; i++) {
      felder.add(DateTime(datum.year, datum.month - 1, ersterTagVormonat + i));
    }

    // Tage des aktuellen Monats hinzufügen.
    for (int i = 1; i <= _tageImMonat(datum); i++) {
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

  /// Prüft, ob ein Datum auf einen Samstag fällt.
  static bool istSamstag(DateTime datum) {
    return datum.weekday == 6;
  }

  /// Prüft, ob ein Datum auf einen Sonntag fällt.
  static bool istSonntag(DateTime datum) {
    return datum.weekday == 7;
  }

  static String formatiereDatum(DateTime datum) {
    //PadLeft ist vom Typ String und deshalb muss man bevor man padLeft benutzt
    //den integer in einen String umwandeln um tage und monate immer in Doppelziffer
    //auszugeben
    return '${datum.day.toString().padLeft(2, '0')}.${datum.month.toString().padLeft(2, '0')}.${datum.year}';
  }

  /// Ermittelt die Anzahl der Tage des angegebenen Monats.
  static int _tageImMonat(DateTime datum) {
    return DateTime(datum.year, datum.month + 1, 0).day;
  }

  /// Ermittelt den ersten Wochentag des angegebenen Monats.
  static int _ersterWochenTagImMonat(DateTime datum) {
    return DateTime(datum.year, datum.month, 1).weekday;
  }

  static String getMonatsName(DateTime datum) {
    List<String> monate = [
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember',
    ];
    int monatsIndex = datum.month - 1;

    return monate[monatsIndex];
  }
}
