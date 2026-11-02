import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/logik/extensions/format_date.dart';
import 'package:kalender_flutter/logik/services/ereignis_service.dart';
import 'package:kalender_flutter/logik/storage/json_storage.dart';

// Hier wurde der Provider ein wenig umgestaltet:
// Anstatt jedes Mal ereignisService.ladeEreignisse(date) zu rufen, wird geschaut ob in einem weiteren Provider (der _savedEreignisse-Map von unten) bereits das gewählte Datum als Key vorhanden ist. Falls ja, nutzt es einfach dessen Wert. Falls nicht, werden alle Ereignisse diesen Tages geladen.
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
