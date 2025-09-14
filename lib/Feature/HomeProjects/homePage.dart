// Feature/HomeProjects/homePage.dart
import 'package:PlanMate/Feature/HomeProjects/widget/HomepageBody.dart';
import 'package:PlanMate/core/helpers/extensions.dart';
import 'package:PlanMate/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routing/routes.dart';
import '../profile/profile_screen.dart';
import 'logic/board_cubit.dart';
import 'logic/board_state.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [HomepageBody(boards: []), ProfileScreen()];

  @override
  void initState() {
    super.initState();
    context.read<BoardCubit>().getBoards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BoardCubit, BoardState>(
        builder: (context, state) {
          if (state is BoardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BoardSuccess) {
            return _currentIndex == 0
                ? HomepageBody(boards: state.boards)
                : ProfileScreen();
          } else if (state is BoardError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(child: Text("No Boards Yet"));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsManager.trelloColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: "Profile",
          ),
        ],
      ),
    floatingActionButton: _currentIndex==0 ?FloatingActionButton(
        onPressed: () async {
          final result = await context.pushNamed(Routes.addBoarderScreen);
          if (result == true) {
            context.read<BoardCubit>().getBoards();
          }
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, color: Colors.white),
      ):null,
      appBar: _currentIndex == 0
          ? AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            )
          : AppBar(
        automaticallyImplyLeading: false,
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
    );
  }
}
