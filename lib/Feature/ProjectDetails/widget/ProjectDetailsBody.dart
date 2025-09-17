import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/coutom_text_field.dart';
import '../data/list_modal.dart';
import '../logic/card_cubit.dart';
import '../logic/card_state.dart';

class TrelloList extends StatefulWidget {
  final String title;
  const TrelloList({super.key, required this.title, required this.listModel});
  final ListModel listModel;
  @override
  State<TrelloList> createState() => _TrelloListState();
}

class _TrelloListState extends State<TrelloList> {
  final TextEditingController _cardController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void addCard() {
    final title = _cardController.text.trim();
    if (title.isNotEmpty) {
      context.read<CardCubit>().addCard(
        listId: widget.listModel.id,
        title: title,
      );
      _cardController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CardCubit>().getCards(widget.listModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardCubit, CardState>(
      listener: (context, state) {
        if (state is CardError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 300.w,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpace(15.h),
                          if (state is CardLoaded)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),

                              itemCount: state.cards.length,
                              itemBuilder: (context, index) {
                                final card = state.cards[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.2,
                                        child: SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: Checkbox(
                                            shape: const CircleBorder(),
                                            value: card.status == 'done',
                                            onChanged: (value) {
                                              final newStatus = value == true
                                                  ? 'done'
                                                  : 'to do';
                                              context
                                                  .read<CardCubit>()
                                                  .updateCardStatus(
                                                    cardId: card.id,
                                                    listId: widget.listModel.id,
                                                    status: newStatus,
                                                  );
                                            },
                                            activeColor: ColorsManager.mainBlue,
                                            checkColor:
                                                ColorsManager.trelloColor,
                                          ),
                                        ),
                                      ),
                                      horizontalSpace(10.w),
                                      Text(
                                        card.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          Row(
                            children: [
                              Icon(Icons.add, color: Colors.white, size: 20),
                              Expanded(
                                child: CustomTextField(
                                  hintText: 'Add a card..',
                                  controller: _cardController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a card title';
                                    }
                                    return null;
                                  },
                                  backgroundColor: ColorsManager.trelloColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: ColorsManager.trelloColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: ColorsManager.trelloColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  textStyle: TextStyles.font16WhiteMedium
                                      .copyWith(fontWeight: FontWeight.w400),

                                  onSubmited: (_) {
                                    addCard();
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(FocusNode());
                                    Future.delayed(
                                      Duration(milliseconds: 100),
                                      () {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(_focusNode);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
