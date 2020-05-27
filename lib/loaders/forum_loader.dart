import 'package:flutter/material.dart';

class ForumLoader extends StatelessWidget {
  final List<String> arr = ["1","2","3","4","5"];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: arr.map((question) =>
          Container(
            height: 180,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration( 
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [BoxShadow(
                color: Colors.black26.withOpacity(0.05),
                offset: Offset(0.0,6.0),
                blurRadius: 10.0,
                spreadRadius: 0.10
              )]
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 70,  
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              radius: 22,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container( 
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.65,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(3)
                                      ),
                                    ),
                                  ), 
                                  SizedBox(height: 5.0),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.31,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(2)
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.31,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 25,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50, 
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(2)
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(2)
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(2)
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ).toList()
    );
  }
}