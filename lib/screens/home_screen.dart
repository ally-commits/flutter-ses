import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sra/screens/blog_screen.dart';
import 'package:sra/screens/forum_screen.dart';
import 'package:sra/screens/loader.dart';
import 'package:sra/utils/var.dart';
import 'package:sra/widgets/blog_posts.dart';
import 'package:sra/widgets/fav_authors.dart';
import 'package:sra/widgets/forum_posts.dart';

typedef void CallBack(int val);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List questions = new List();
  final dio = new Dio();

  @override
  void initState() {
    this._getData();
    super.initState(); 
  }
  void _getData() async { 
    var url = backendServer + "/questions";
    try {
      print(url);
      final response = await dio.get(url); 
      List tList = new List();  
      for (int i = 0; i < response.data["data"].length; i++) {
        tList.add(response.data["data"][i]); 
      } 
      setState(() {
        isLoading = false;
        questions.addAll(tList);
        print("done"); 
      });
    } catch(e) {
      print(e);
    } 
  }
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: SafeArea(
          child: ListView(
            children: <Widget>[ 
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Sra",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Icon(
                          Icons.menu,
                          size: 32.0,
                          color: Colors.black,
                        )
                      ],
                    )
                  ],
                ), 
              ),
              Column(
                children: <Widget>[
                  FavAuthors(), 
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Recent Posts",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 16.0
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  BlogPosts(), 
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Recent Questions",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ForumScreen()
                                )
                              )
                            },
                            child: Text(
                              "See all",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 16.0
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ), 
                  Posts(questions: questions) 
                ],
              ) 
            ],
          ),
      ),
    );
  }
}