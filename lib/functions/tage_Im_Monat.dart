/// Ermittelt die Anzahl der Tage des angegebenen Monats.
int tageImMonat(DateTime datum) {
  return DateTime(datum.year, datum.month + 1, 0).day;
}
