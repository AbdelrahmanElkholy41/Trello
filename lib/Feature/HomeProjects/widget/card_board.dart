import 'package:flutter/material.dart';

import '../../ProjectDetails/ProjectDetails.dart';

class card_board extends StatelessWidget {
  const card_board({
    super.key,
    required this.boards,
  });

  final String boards;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProjectDetails(),
            ),
          );
        },
        child: Card(
          child: ListTile(
            title: Text(
              boards,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            subtitle: const Text('3 Tasks | 3 Members'),
          ),
        ),

      ),
    );
  }
}
