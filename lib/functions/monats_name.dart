/// Ermittelt den deutschen Monatsnamen aus einem [DateTime].
///
/// Gibt den Monatsnamen als [String] zurück.
String monatsName(DateTime datum) {
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
