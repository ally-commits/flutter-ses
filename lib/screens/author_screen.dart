import 'package:dio/dio.dart';
import 'package:flutter/material.dart'; 
import 'package:sra/screens/loader.dart';
import 'package:sra/utils/var.dart';

class AuthorScreen extends StatefulWidget {
  @override
  final int id;

  AuthorScreen({this.id});
  _AuthorScreenState createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  List author = new List();
  final dio = new Dio();
  bool isLoading = true;
  @override

  void initState()  {
    this._getData();
  }
  @override
  void _getData() async {
    var url = backendServer + "/get-students/" + widget.id.toString();
    try {
      print(url);
      final response = await dio.get(url); 
      setState(() {
        isLoading = false; 
        author = response.data;
        print("done"); 
      });
    } catch(e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: 
        isLoading ?
          Center(
            child: Loader(),
          ) :
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: <Widget>[
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: EdgeInsets.all(5.0),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 100,
                  height: 100,  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100)
                  ),  
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: NetworkImage(author[0]["path"]), 
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "${author[0]["studentName"]} (${author[0]['username']})", 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      author[0]["cName"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: Colors.white
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
                child: Text(
                  author[0]["bio"],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: (MediaQuery.of(context).size.width - 30) / 3,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.white.withOpacity(.5)
                            )
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${author[0]["blogCount"]}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Posts",
                              style: TextStyle(
                                color: Colors.white, 
                              ),
                            )
                          ],
                        )
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width - 30) / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${author[0]["replyCount"]}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Replies",
                              style: TextStyle(
                                color: Colors.white, 
                              ),
                            )
                          ],
                        )
                      ), 
                      Container(
                        width: (MediaQuery.of(context).size.width - 30) / 3,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.white.withOpacity(.5)
                            )
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${author[0]["blogFollowers"]}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Followers",
                              style: TextStyle(
                                color: Colors.white, 
                              ),
                            )
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(  
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    )
                  ),
                  child: Center(child: Text("State : ${author[0]['stateName']}")),
                ),
              )
            ],
          ),
      ),
    );
  }
}