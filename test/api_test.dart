import 'package:flutter_test/flutter_test.dart';
import 'package:kalender_flutter/logik/services/ereignis_service.dart';

void main() {
  test('api test', () async {
    final ereignisService = EreignisService();
    final ereignisse = await ereignisService.ladeEreignisse(DateTime.now());
    print(ereignisse);
  });
}
