import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trello/core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../ProjectDetails/widget/UserAvater.dart';

class MeanuScreen extends StatelessWidget {
  const MeanuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board menu'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: ColorsManager.trelloColor.withOpacity(1),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text "Members"
                    Text(
                      'Members',
                      style: TextStyles.font14LightGrayRegular.copyWith(fontSize: 18),
                    ),
                    verticalSpace(10.h),

                    SizedBox(
                      height: 60.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 9, // 7 avatars + 1 زرار +
                        itemBuilder: (context, index) {
                          if (index < 8) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: UserAvatar(userName: 'Abdelrahman E $index'),
                            );
                          } else {
                            // الزرار + آخر العنصر
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: RawMaterialButton(
                                onPressed: () {},
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
                    ),
                    verticalSpace(15.h)
                  ],
                ),
              
              ),
            ],
          ),
        ),
      ),
    );
  }
}
