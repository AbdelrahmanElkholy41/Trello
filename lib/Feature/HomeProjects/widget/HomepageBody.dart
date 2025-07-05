import 'package:flutter/material.dart';

class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Text(
            'Abdelrahman',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            child: Card(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  ListTile(
                      title:Text("Project A",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    subtitle: Text('3 Tasks | 3 Member'),
                ),
            
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
