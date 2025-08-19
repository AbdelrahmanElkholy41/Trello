import 'package:flutter/material.dart';

import '../ProjectDetails/widget/UserAvater.dart';

class MeanuScreen extends StatelessWidget {
  const MeanuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  UserAvatar(userName: 'Abdelrahman Elk holy'),
                   SizedBox(width: 8),
                   UserAvatar(userName: 'Abdelrahman Elk holy'),
                   SizedBox(width: 8),
                   UserAvatar(userName: 'Abdelrahman Elk holy'),
                   SizedBox(width: 8),
                   UserAvatar(userName: 'Abdelrahman Elk holy'),
                   SizedBox(width: 8),
                  RawMaterialButton(
                    onPressed: (){},
                    elevation: 2.0,
                    fillColor: Colors.grey,
                    shape: CircleBorder(),
                    constraints: BoxConstraints.tight(Size(48, 48)),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
      
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    ),
    );
  }
}
