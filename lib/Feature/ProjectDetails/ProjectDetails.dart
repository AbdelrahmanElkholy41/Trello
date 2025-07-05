import 'package:flutter/material.dart';
import 'package:trello/Feature/ProjectDetails/widget/ProjectDetailsBody.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

      ),
      body: ProjectDetailsBody(),
    );
  }
}
