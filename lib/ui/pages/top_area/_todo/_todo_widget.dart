import 'package:flutter/material.dart';

class ToDoWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 8, 19, 49).withValues(alpha: 0.55),
        border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.55)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ToDo's",
            style: TextStyle(color: Colors.cyanAccent, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Noch keine Notizen', style: TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }
}
