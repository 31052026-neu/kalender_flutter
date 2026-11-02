import 'package:flutter_riverpod/flutter_riverpod.dart';

final refCalendarState = NotifierProvider<KalendarNotifier, KalendarState>(KalendarNotifier.new);

class KalendarState {
  final DateTime dargestelltesDatum;
  final DateTime ausgewaehltesDatum;

  KalendarState({DateTime? dargestelltesDatum, required this.ausgewaehltesDatum})
    : dargestelltesDatum = dargestelltesDatum ?? DateTime.now();

  KalendarState copyWith({DateTime Function()? dargestelltesDatum, DateTime Function()? ausgewaehltesDatum}) {
    return KalendarState(
      dargestelltesDatum: dargestelltesDatum != null ? dargestelltesDatum() : this.dargestelltesDatum,
      ausgewaehltesDatum: ausgewaehltesDatum != null ? ausgewaehltesDatum() : this.ausgewaehltesDatum,
    );
  }
}

class KalendarNotifier extends Notifier<KalendarState> {
  @override
  KalendarState build() => KalendarState(ausgewaehltesDatum: DateTime.now());

  void moveToNextMonth() {
    final newDargestelltesDatum = DateTime(state.dargestelltesDatum.year, state.dargestelltesDatum.month + 1, 1);

    state = state.copyWith(
      dargestelltesDatum: () => newDargestelltesDatum,
      ausgewaehltesDatum: () => newDargestelltesDatum,
    );
  }

  void moveToPreviousMonth() {
    final newDargestelltesDatum = DateTime(state.dargestelltesDatum.year, state.dargestelltesDatum.month - 1, 1);

    state = state.copyWith(
      dargestelltesDatum: () => newDargestelltesDatum,
      ausgewaehltesDatum: () => newDargestelltesDatum,
    );
  }

  /// Wechselt den angezeigten Monat.
  void changeMonth(int newMonth) {
    final newDargestelltesDatum = DateTime(state.dargestelltesDatum.year, newMonth, 1);

    state = state.copyWith(
      dargestelltesDatum: () => newDargestelltesDatum,
      ausgewaehltesDatum: () => newDargestelltesDatum,
    );
  }

  /// Speichert das ausgewählte Datum und lädt dessen Ereignisse.
  void changeDay(DateTime newDay) async {
    final newAusgewaehltesDatum = newDay;
    final newDargestelltesDatum = DateTime(newDay.year, newDay.month, newDay.day);
    state = state.copyWith(
      ausgewaehltesDatum: () => newAusgewaehltesDatum,
      dargestelltesDatum: () => newDargestelltesDatum,
    );
  }
}
