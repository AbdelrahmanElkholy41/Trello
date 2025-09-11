import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // ✅ لازم ده

import '../../ProjectDetails/ProjectDetails.dart';
import '../data/board_modal.dart';
import '../logic/board_cubit.dart';
import '../logic/board_state.dart';
import 'card_board.dart';

class HomepageBody extends StatelessWidget {
   HomepageBody({super.key, required this.boards});
  final List<Board> boards;
   final String  name = Supabase.instance.client.auth.currentUser!.userMetadata?['name'] ?? " "; // ✅ default value


   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text(
          name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: boards.length,
              itemBuilder: (BuildContext context, int index) {
                return card_board(boards: boards[index]);

              },
            ),
          ),
        ],
      ),
    );
  }
}

