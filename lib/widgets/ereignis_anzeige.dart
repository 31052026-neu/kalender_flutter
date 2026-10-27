import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalender_flutter/provider/provider.dart';
import 'package:kalender_flutter/styles/comic_rahmen.dart';

/// Zeigt historische Ereignisse zum ausgewählten Datum an.
class EreignisAnzeige extends ConsumerWidget {
  final DateTime datum;

  const EreignisAnzeige({super.key, required this.datum});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ereignisse = ref.watch(refHistorischeEreignisse(datum));

    return ereignisse.when(
      data: (ereignisse) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              //spread Operator(...)
              ...ereignisse.map((ereignis) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: erstelleRahmen(Colors.black, 3),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ereignis.year.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(ereignis.text, style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 10),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Text('Error: $error');
      },
      loading: () {
        return Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
