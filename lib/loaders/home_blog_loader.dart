import 'package:flutter/material.dart';

class HomeBlogLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[ 
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          height: MediaQuery.of(context).size.width * 0.90, 
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) { 
              return Padding(
                padding: EdgeInsets.only(left: 20.0,top: 20.0, bottom: 20.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      height: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration( 
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.grey.withOpacity(0.2), 
                      ), 
                    ),
                    Positioned(
                      bottom: 10.0,
                      left: 10.0, 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.72,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.grey.withOpacity(0.3),
                              ),
                              SizedBox(width: 8.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      right: 10.0,
                      child: Row(
                        children: <Widget>[ 
                          SizedBox(width: 5.0),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.10,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5)
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      right: 10.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.06,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2)
                        ),
                      )
                    )
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 5.0)
      ],
    );
  }
}