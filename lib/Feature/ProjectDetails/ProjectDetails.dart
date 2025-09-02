import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello/Feature/ProjectDetails/widget/ProjectDetailsBody.dart';

import '../HomeProjects/data/board_modal.dart';
import '../meanu/meanu_screen.dart';
import 'logic/list_cubit.dart';
import 'logic/list_state.dart';

class ProjectDetails extends StatefulWidget {
  final Board boardId;

  const ProjectDetails({super.key, required this.boardId});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  void initState() {
    super.initState();

    print("Board ID: ${widget.boardId}");
    context.read<ListCubit>().getLists(widget.boardId.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListCubit, ListState>(
      listener: (context, state) {
        if (state is ListError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ListLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ListLoaded) {
          final lists = state.lists;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.boardId.name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 28),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (_, __, ___) => const MeanuScreen(),
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
            body: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      final list = lists[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TrelloList(title: list.title),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text("No data available")),
          );
        }
      },
    );
  }
}
