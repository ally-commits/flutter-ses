import 'package:flutter/material.dart';

class AuthorLoader extends StatelessWidget {
  final List arr = [1,2,3,4,5,6,7,8,9,0];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.withOpacity(0.3)
              ), 
            ),
          );
        }
      ),
    );
  }
}