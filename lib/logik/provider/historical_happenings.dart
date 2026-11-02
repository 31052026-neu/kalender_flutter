import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/logik/extensions/format_date.dart';
import 'package:kalender_flutter/logik/services/ereignis_service.dart';
import 'package:kalender_flutter/logik/storage/json_storage.dart';

// Ich hatte über das Wochenende die Idee zur persistenten Datenspeicherung der API Abrufe. So werden Schritt für Schritt die langen Ladezeiten der API reduziert und in einer JSON File abgespeichert.
// Hierzu passiert folgendes: Der API Abruf holt sich alle Ereignisse eines Tages (des ausgewählten) und speichert diese, solange sie dort noch nicht sind, in die JSON-File. Wir der Tag erneut abgerufen, holt er sich die Daten aus der File. Die UI selbst kümmert sich dann darum, dass 5 zufällige Ereignisse ausgewählt werden.
final refHistorischeEreignisse = FutureProvider.family<List<Ereignis>, DateTime>((ref, date) async {
  final ereignisService = EreignisService();
  final key = date.formatGermanStandardWithoutYear();

  final cache = await ref.watch(_localCacheProvider.future);

  if (cache[key] != null) {
    return cache[key]!;
  }

  final ereignisse = await ereignisService.ladeEreignisse(date);

  await ref.read(_localCacheProvider.notifier).updateCache(key, ereignisse);

  return ereignisse;
});

final _localCacheProvider = AsyncNotifierProvider<_LocalCacheNotifier, Map<String, List<Ereignis>>>(
  () => _LocalCacheNotifier(),
);

class _LocalCacheNotifier extends AsyncNotifier<Map<String, List<Ereignis>>> {
  final _jsonService = JsonStorageService();

  @override
  Future<Map<String, List<Ereignis>>> build() async {
    final rawData = await _jsonService.readJsonData();

    return rawData.map((k, v) => MapEntry(k, (v as List<dynamic>).map((e) => Ereignis.fromJson(e)).toList()));
  }

  Future<void> updateCache(String key, List<Ereignis> ereignisse) async {
    final currentCache = await future;

    final updatedCache = Map<String, List<Ereignis>>.from(currentCache);
    updatedCache[key] = ereignisse;

    state = AsyncData(updatedCache);

    _jsonService.writeJsonData(updatedCache.map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList()))).catchError((
      error,
    ) {
      print("Fehler beim Schreiben ins JSON: $error");
    });
  }
}
