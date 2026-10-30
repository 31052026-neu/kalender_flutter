import 'package:flutter/material.dart';
import 'package:kalender_flutter/logik/functions/kalender_service.dart';

class WeekdaysHeader extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...KalenderService.weekDays.map((tag) {
          return Expanded(
            child: Center(
              child: Text(tag, style: const TextStyle(color: Colors.cyanAccent, fontSize: 11)),
            ),
          );
        }),
      ],
    );
  }
}
