class KalenderService {
  static List<String> get weekDays => [
    'Mo',
    'Di',
    'Mi',
    'Do',
    'Fr',
    'Sa',
    'So',
  ];

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
}
