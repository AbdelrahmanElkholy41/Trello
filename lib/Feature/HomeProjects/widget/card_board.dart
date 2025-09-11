import 'package:PlanMate/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/routing/routes.dart';
import '../../ProjectDetails/ProjectDetails.dart';
import '../data/board_modal.dart';

class card_board extends StatelessWidget {
  const card_board({
    super.key,
    required this.boards,
  });
  final Board boards;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {

          context.pushNamed(Routes.projectDetailsScreen,
          arguments: boards
          );
        },
        child: Card(
          child: ListTile(
            title: Text(
              boards.name,
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
