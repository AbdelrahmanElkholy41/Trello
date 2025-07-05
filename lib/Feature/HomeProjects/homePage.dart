import 'package:flutter/material.dart';
import 'package:trello/Feature/HomeProjects/widget/HomepageBody.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),

        child: Icon(Icons.add, color: Colors.white,size: 35,),

      ),
      appBar: AppBar(title: Text('Home', style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700))),
      body: HomepageBody(),
    );
  }
}
