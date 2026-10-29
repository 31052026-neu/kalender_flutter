import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/logik/services/ereignis_service.dart';

final refCalendarState = NotifierProvider<KalendarNotifier, KalendarState>(
  KalendarNotifier.new,
);

class KalendarState {
  final DateTime dargestelltesDatum;
  final DateTime? ausgewaehltesDatum;

  KalendarState({DateTime? dargestelltesDatum, this.ausgewaehltesDatum})
    : dargestelltesDatum = dargestelltesDatum ?? DateTime.now();

  KalendarState copyWith({
    DateTime Function()? dargestelltesDatum,
    DateTime? Function()? ausgewaehltesDatum,
  }) {
    return KalendarState(
      dargestelltesDatum: dargestelltesDatum != null
          ? dargestelltesDatum()
          : this.dargestelltesDatum,
      ausgewaehltesDatum: ausgewaehltesDatum != null
          ? ausgewaehltesDatum()
          : this.ausgewaehltesDatum,
    );
  }
}

class KalendarNotifier extends Notifier<KalendarState> {
  @override
  KalendarState build() => KalendarState();

  void moveToNextMonth() {
    final newDargestelltesDatum = DateTime(
      state.dargestelltesDatum.year,
      state.dargestelltesDatum.month + 1,
      1,
    );
    final newAusgewaehltesDatum = null;
    state = state.copyWith(
      dargestelltesDatum: () => newDargestelltesDatum,
      ausgewaehltesDatum: () => newAusgewaehltesDatum,
    );
  }

  void moveToPreviousMonth() {
    final newDargestelltesDatum = DateTime(
      state.dargestelltesDatum.year,
      state.dargestelltesDatum.month - 1,
      1,
    );
    final newAusgewaehltesDatum = null;
    state = state.copyWith(
      dargestelltesDatum: () => newDargestelltesDatum,
      ausgewaehltesDatum: () => newAusgewaehltesDatum,
    );
  }

  /// Wechselt den angezeigten Monat.
  void changeMonth(int newMonth) {
    final newDargestelltesDatum = DateTime(
      state.dargestelltesDatum.year,
      newMonth,
      1,
    );
    final newAusgewaehltesDatum = null;

    state = state.copyWith(
      dargestelltesDatum: () => newDargestelltesDatum,
      ausgewaehltesDatum: () => newAusgewaehltesDatum,
    );
  }

  /// Speichert das ausgewählte Datum und lädt dessen Ereignisse.
  void changeDay(DateTime newDay) async {
    final newAusgewaehltesDatum = newDay;

    state = state.copyWith(ausgewaehltesDatum: () => newAusgewaehltesDatum);
  }
}

final refHistorischeEreignisse =
    FutureProvider.family<List<Ereignis>, DateTime>((ref, date) async {
      final ereignisService = EreignisService();
      final ereignisse = await ereignisService.ladeEreignisse(date);

      return ereignisse;
    });
