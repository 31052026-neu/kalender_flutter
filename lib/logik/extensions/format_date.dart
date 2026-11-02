extension FormatDate on DateTime {
  String formatGermanStandard() =>
      //PadLeft ist vom Typ String und deshalb muss man bevor man padLeft benutzt
      //den integer in einen String umwandeln um tage und monate immer in Doppelziffer
      //auszugeben
      '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.$year';
  String formatGermanStandardWithoutYear() => '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}';
}
