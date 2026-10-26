import 'package:flutter/foundation.dart';

class KalenderPageController extends ChangeNotifier {
  DateTime dargestelltesDatum = DateTime.now();

  void naechsterMonat() {
    dargestelltesDatum = DateTime(
      dargestelltesDatum.year,
      dargestelltesDatum.month + 1,
      1,
    );
    notifyListeners();
  }

  void vorherigerMonat() {
    dargestelltesDatum = DateTime(
      dargestelltesDatum.year,
      dargestelltesDatum.month - 1,
      1,
    );
    notifyListeners();
  }
}
