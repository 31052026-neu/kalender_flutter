import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/logik/functions/kalender_service.dart';
import 'package:kalender_flutter/logik/provider/provider.dart';

class MonthNavigationBar extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarNotifier = ref.watch(refCalendarState.notifier);
    final calendarState = ref.watch(refCalendarState);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            calendarNotifier.moveToPreviousMonth();
          },
          icon: const Icon(Icons.chevron_left, color: Colors.cyanAccent),
        ),

        Text(
          KalenderService.getMonatsName(calendarState.dargestelltesDatum),
          style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16),
        ),

        IconButton(
          onPressed: () {
            calendarNotifier.moveToNextMonth();
          },
          icon: const Icon(Icons.chevron_right, color: Colors.cyanAccent),
        ),
      ],
    );
  }
}
