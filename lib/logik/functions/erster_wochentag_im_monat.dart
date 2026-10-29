/// Ermittelt den ersten Wochentag des angegebenen Monats.
int ersterWochenTagImMonat(DateTime datum) {
  return DateTime(datum.year, datum.month, 1).weekday;
}
