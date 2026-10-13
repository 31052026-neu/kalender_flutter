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
}
