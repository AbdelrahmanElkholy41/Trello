import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/coutom_text_field.dart';
import '../../core/widgets/custom_main_button.dart';
import 'logic/invitation_cubit/invitation_cubit.dart';


class InvitePersoneScreen extends StatelessWidget {
  final String? prefilledEmail;
  final int? boardId;


  const InvitePersoneScreen({
    super.key,
    this.prefilledEmail,
    this.boardId,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
    TextEditingController(text: prefilledEmail);
    final adminId = Supabase.instance.client.auth.currentUser?.id;

    return BlocProvider(
      create: (_) => InvitationCubit(),
      child: BlocListener<InvitationCubit, InvitationState>(
        listener: (context, state) {
          if (state is InvitationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invitation sent!')),

            );
            Navigator.pop(context);
          } else if (state is InvitationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Invite Person')),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
            child: Column(
              children: [
                CustomTextField(
                  controller: emailController,
                  hintText: 'Enter Email',
                  validator: (value) {},
                  backgroundColor: ColorsManager.trelloColor,
                  textStyle: TextStyles.font16WhiteMedium,
                ),
                const Spacer(),
                BlocBuilder<InvitationCubit, InvitationState>(
                  builder: (context, state) {
                    return AppTextButton(
                      buttonText: state is InvitationLoading
                          ? 'Sending...'
                          : 'Invite',
                      textStyle: TextStyles.font14DarkBlueBold,
                      onPressed: () {
                        final email = emailController.text.trim();
                        if (email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter an email'),
                            ),
                          );
                          return;
                        }

                        if (boardId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No board selected!'),
                            ),
                          );
                          return;
                        }

                        context
                            .read<InvitationCubit>()
                            .sendInvitation(emailController.text, boardId!, invitedBy: adminId);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

