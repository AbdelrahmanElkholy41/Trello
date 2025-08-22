import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';

class TrelloList extends StatefulWidget {
  final String title;

  const TrelloList({super.key, required this.title});

  @override
  State<TrelloList> createState() => _TrelloListState();
}

class _TrelloListState extends State<TrelloList> {
  List<String> cards = ["Task 1", "Task 2"];

  void addCard() {
    setState(() {
      cards.add("New Card ${cards.length + 1}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                // العنوان
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(8.h),
                ListView.builder(
                  shrinkWrap: true,

                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        cards[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
                InkWell(
                  onTap: addCard,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: const [
                        Icon(Icons.add, color: Colors.white70, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Add a card",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
