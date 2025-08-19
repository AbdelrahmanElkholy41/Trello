import 'package:flutter/material.dart';
import 'package:trello/Feature/HomeProjects/widget/HomepageBody.dart';

import '../add_boarder/add_boarder_screen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddBoarderScreen()));
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),

        child: Icon(Icons.add, color: Colors.white,),

      ),
      appBar: AppBar(title: Text('Home', style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700))),
      body: HomepageBody(),
    );
  }
}


