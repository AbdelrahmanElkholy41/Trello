import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello/Feature/HomeProjects/widget/HomepageBody.dart';
import 'package:trello/core/helpers/extensions.dart';

import '../../core/routing/routes.dart';
import '../add_boarder/add_boarder_screen.dart';
import 'logic/board_cubit.dart';
import 'logic/board_state.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         context.pushNamed(Routes.addBoarderScreen);
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<BoardCubit, BoardState>(
        builder: (context, state) {
          if (state is BoardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BoardSuccess) {
            //context.read<BoardCubit>().getBoards();
            return HomepageBody(boards: state.boards);
          } else if (state is BoardError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(child: Text("No Boards Yet"));
        },
      ),
    );
  }
}
