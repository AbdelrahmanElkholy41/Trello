import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello/Feature/ProjectDetails/widget/ProjectDetailsBody.dart';
import 'package:trello/Feature/ProjectDetails/widget/custom_app_bar.dart';
import 'package:trello/core/theming/colors.dart';
import 'package:trello/core/widgets/coutom_text_field.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/custom_main_button.dart';
import '../HomeProjects/data/board_modal.dart';
import '../meanu/meanu_screen.dart';
import 'logic/card_cubit.dart';
import 'logic/list_cubit.dart';
import 'logic/list_state.dart';

class ProjectDetails extends StatefulWidget {
  final Board boardId;
  const ProjectDetails({super.key, required this.boardId});
  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  void addList() {
    final title = _titleController.text.trim();
    if (title.isNotEmpty) {
      context.read<ListCubit>().addList(
        boardId: widget.boardId.id,
        name: title,
      );
      _titleController.clear();
      Navigator.pop(context);
    }
  }

  final TextEditingController _titleController = TextEditingController();

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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is ListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListLoaded) {
          final lists = state.lists;
          return Scaffold(
            appBar: CustomAppBar(boardId: widget.boardId),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: lists.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < lists.length) {
                            final list = lists[index];
                            return BlocProvider(
                              create: (context) => CardCubit(),
                              child: TrelloList(
                                title: list.name,
                                listModel: list,
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: ColorsManager.trelloColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add, color: Colors.white),
                                          SizedBox(width: 8),
                                          Text(
                                            "Add another list",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(
                                            context,
                                          ).viewInsets.bottom,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomTextField(
                                                controller: _titleController,
                                                hintText: 'List Title',
                                                validator: (value) {},
                                                backgroundColor:
                                                    ColorsManager.trelloColor,
                                                textStyle: TextStyles
                                                    .font16WhiteMedium,
                                                onSubmited: (_) => addList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }
}
