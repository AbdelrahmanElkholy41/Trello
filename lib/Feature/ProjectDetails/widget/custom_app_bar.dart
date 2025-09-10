import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../HomeProjects/data/board_modal.dart';
import '../../meanu/meanu_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.boardId,
  });

  final Board boardId;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        boardId.name,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.more_vert, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 400),
                    pageBuilder: (_, __, ___) => MeanuScreen(boardId: boardId,),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final tween = Tween(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
