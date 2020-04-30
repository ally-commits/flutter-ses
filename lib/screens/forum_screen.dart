import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sra/screens/loader.dart';
import 'package:sra/utils/var.dart';
import 'package:sra/widgets/popular_topics.dart';
import 'package:sra/widgets/forum_posts.dart';
import 'package:sra/widgets/top_bar.dart';

class ForumScreen extends StatefulWidget {
  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final dio = new Dio();

  static int page = 1;
  static int selectedChannel;

  ScrollController _sc = new ScrollController();

  bool questionLoading = false;
  bool contentLoading = true;
  bool questionCompleted = false;

  List questions = new List();
  List contents = new List();

  List<Color> colors  = [
    Colors.purple, Colors.blueAccent, Colors.greenAccent, Colors.redAccent,Colors.purple, Colors.blueAccent, Colors.greenAccent, Colors.redAccent
  ];

  @override
  void initState() {
    this._getContents();
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent && !questionCompleted) {
        _getMoreData(page);
      }
    });
  }
 
  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }
  void _getContents() async {
    try {
      var url = backendServer + "/channels";
      print(url);
      final response = await dio.get(url);
      List tList = new List(); 
      for (int i = 0; i < response.data.length; i++) {
        tList.add(response.data[i]);
      } 
      setState(() {
        contentLoading = false;
        contents.addAll(tList);
        selectedChannel = contents[0]["id"];        
        this._getMoreData(page); 
      });
    } catch(e) {

    }
  }
  void _getMoreData(int index) async {
    if (!questionLoading) {
      setState(() {
        questionLoading = true;
      });
      var url = backendServer + "/channel/"+ selectedChannel.toString() +"?page=" + page.toString();
      try {
        final response = await dio.get(url);
        List tList = new List(); 
        for (int i = 0; i < response.data["data"].length; i++) {
          tList.add(response.data["data"][i]);
        }  
        setState(() {
          questionLoading = false;
          questionCompleted = response.data["next_page_url"] == null ? true : false;
          questions.addAll(tList);
          page++;
        });
      } catch(e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[ 
                  Text(
                    "Sra, Forum",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Find Topics you like to read",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14.0,
                        ),
                      ),
                      Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container( 
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0)
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[ 
                TopBar(), 
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Popular Topics",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                ), 
                contentLoading ? 
                Loader() :
                Container(
                  height: 120,  
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: contents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedChannel = contents[index]["id"];
                            page = 1;
                            questions = [];
                          });
                          this._getMoreData(page);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(left: 20.0), 
                          width: 170,
                          decoration: BoxDecoration(
                            color: colors[index],
                            borderRadius: BorderRadius.circular(10.0), 
                            border: Border.all(
                              width: selectedChannel == contents[index]["id"] ? 3 : 0,
                              color: Theme.of(context).primaryColor
                            )
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  contents[index]["channel_name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${contents[index]['questionCount']} questions",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    letterSpacing: .7
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
                  child: Text(
                    "Recent Posts",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Posts(questions: questions)
              ],
            )
          ),
          questionCompleted ? 
          Text(
            "----------------",
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.grey.withOpacity(0.6)
            )
          ) : Loader()
        ],
        controller: _sc,
      ) 
    );
  }
}