import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trello/Feature/ProjectDetails/widget/tabController.dart';

import 'UserAvater.dart';

class ProjectDetailsBody extends StatelessWidget {
  const ProjectDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Text(
            'Project A',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
          ),
          const SizedBox(height: 15),

          // 🧑‍🤝‍🧑 أعضاء الفريق
          Row(
            children: [
              const UserAvatar(userName: 'Abdelrahman Elk holy'),
              const SizedBox(width: 8),
              const UserAvatar(userName: 'Abdelrahman Elk holy'),
              const SizedBox(width: 8),
              const UserAvatar(userName: 'Abdelrahman Elkholy'),
              const SizedBox(width: 8),
              const UserAvatar(userName: 'Abdelrahman Elkholy'),
              const SizedBox(width: 8),
              RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: Colors.grey,
                shape: CircleBorder(),
                constraints: BoxConstraints.tight(Size(48, 48)),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Expanded(
            child: TabControllerr(),
          )
        ],
      ),
    );
  }
}
