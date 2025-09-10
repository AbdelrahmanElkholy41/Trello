// Feature/HomeProjects/homePage.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello/Feature/HomeProjects/widget/HomepageBody.dart';
import 'package:trello/core/helpers/extensions.dart';

import '../../core/routing/routes.dart';
import 'logic/board_cubit.dart';
import 'logic/board_state.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();

    context.read<BoardCubit>().getBoards(); // ✅ استدعاء أول ما الصفحة تفتح
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.pushNamed(Routes.addBoarderScreen);

          /// ✅ لو رجعت قيمة true يبقى فيه إضافة جديدة → نعمل refresh
          if (result == true) {
            context.read<BoardCubit>().getBoards();
          }
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
