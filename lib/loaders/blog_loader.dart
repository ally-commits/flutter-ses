import 'package:flutter/material.dart';

class BlogLoader extends StatelessWidget {
  final List<String> arr = ["1","2","3","4","5"];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: arr.map((blog) =>
          Container(
            margin: EdgeInsets.only(bottom: 15.0),
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration( 
              color: Colors.grey.withOpacity(0.2),
              boxShadow: [BoxShadow(
                color: Color(0xFFFAFAFA),
                offset: Offset(0.0,10.0),
                blurRadius: 10.0,
                spreadRadius: 0.5
              )]
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.0)
                    ), 
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.68, 
                    padding: EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.grey.withOpacity(0.3),
                            ),
                            SizedBox(width: 10.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.547,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Container( 
                          height: 55,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.72,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.29,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(2)
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.29,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(2)
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ).toList()
      ),
    );
  }
}