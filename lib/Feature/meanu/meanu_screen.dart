import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../HomeProjects/data/board_modal.dart';
import '../ProjectDetails/widget/UserAvater.dart';
import 'invite_persone_screen.dart';
import 'logic/menu_cubit/menu_cubit.dart';
import 'logic/menu_cubit/menu_state.dart';

class MeanuScreen extends StatefulWidget {
  const MeanuScreen({super.key, required this.boardId});
  final Board boardId;

  @override
  State<MeanuScreen> createState() => _MeanuScreenState();
}

class _MeanuScreenState extends State<MeanuScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BoardMembersCubit>().getBoardMembers(widget.boardId.id);
  }

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<BoardMembersCubit, BoardMembersState>(
      listener: (context, state) {
        if (state is BoardMembersError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Board menu')),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpace(30.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: ColorsManager.trelloColor.withOpacity(1),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Members',
                          style: TextStyles.font14LightGrayRegular.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        verticalSpace(10.h),

                        if (state is BoardMembersSuccess)
                          SizedBox(
                            height: 60.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.members.length + 1,
                              itemBuilder: (context, index) {
                                if (index < state.members.length) {
                                  final member = state.members[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: BoardMemberWithStar(userName: member['name'],isOwner: member['role']=='owner' )
                                  );
                                } else {
                                  // زرار الإضافة
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: Duration(milliseconds: 400),
                                            pageBuilder: (_, __, ___) =>
                                                InvitePersoneScreen(boardId: widget.boardId.id),
                                            transitionsBuilder: (
                                                context,
                                                animation,
                                                secondaryAnimation,
                                                child,
                                                ) {
                                              final tween = Tween(
                                                begin: const Offset(0, 1),
                                                end: Offset.zero,
                                              ).chain(
                                                CurveTween(curve: Curves.easeInOut),
                                              );
                                              return SlideTransition(
                                                position: animation.drive(tween),
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      elevation: 2.0,
                                      fillColor: Colors.grey,
                                      shape: const CircleBorder(),
                                      constraints: BoxConstraints.tight(Size(62, 60)),
                                      child: const Icon(Icons.add, color: Colors.white),
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        else if (state is BoardMembersLoading)
                          CircularProgressIndicator()
                        else
                          verticalSpace(15.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

