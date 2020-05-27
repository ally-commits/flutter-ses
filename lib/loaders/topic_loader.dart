import 'package:flutter/material.dart';

class TopicLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,  
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              Container(
                width: 170,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0), 
                ),
                margin: EdgeInsets.only(left: 20.0), 
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(left: 20.0), 
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), 
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}