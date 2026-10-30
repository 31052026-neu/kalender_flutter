import 'package:flutter/material.dart';
import 'package:kalender_flutter/ui/pages/bottom_area/_calendar_table/_weekdays_header/_weekdays_header.dart';
import 'package:kalender_flutter/ui/pages/bottom_area/_monats_naviagtion/_month_naviagtion_bar.dart';
import 'package:kalender_flutter/ui/widgets/datums_anzeige.dart';
import 'package:kalender_flutter/ui/pages/bottom_area/_calendar_table/_calendar/kalender.dart';

class BottomArea extends StatelessWidget {
  final DateTime ausgewaehltesDatum;

  const BottomArea({required this.ausgewaehltesDatum, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF030712).withValues(alpha: 0.35),
        border: Border(top: BorderSide(color: Colors.cyanAccent.withValues(alpha: 0.45))),
      ),
      child: Column(
        children: [
          /// Monatsnavigation
          const MonthNavigationBar(),

          /// Wochentage
          const WeekdaysHeader(),

          /// Kalenderraster
          Expanded(flex: 1, child: Kalender()),

          /// Anzeige des ausgewählten Datums.
          DatumsAnzeige(datum: ausgewaehltesDatum),
        ],
      ),
    );
  }
}
