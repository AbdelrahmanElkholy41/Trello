import 'package:flutter/material.dart';
import 'package:trello/Feature/ProjectDetails/widget/ProjectDetailsBody.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        onPressed:(){},child: Icon(Icons.add,color: Colors.white,),),
      appBar: AppBar(

      ),
      body: ProjectDetailsBody(),
    );
  }
}
