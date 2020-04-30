import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sra/screens/loader.dart';
import 'package:sra/utils/var.dart';
import 'package:sra/widgets/popular_topics.dart';
import 'package:sra/widgets/forum_posts.dart';
import 'package:sra/widgets/recent_posts.dart';
import 'package:sra/widgets/top_bar.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {

  final dio = new Dio();

  static int page = 1;
  static int selectedCategory;

  ScrollController _sc = new ScrollController();

  bool blogLoading = false;
  bool blogCompleted = false;
  bool contentLoading = false;

  List blogs = new List();
  List contents = new List();

  List<Color> colors  = [
    Colors.purple, Colors.blueAccent, Colors.greenAccent, Colors.redAccent,Colors.purple, Colors.blueAccent, Colors.greenAccent, Colors.redAccent
  ];

  @override
  void initState() {
    this._getContents();
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent && !blogCompleted) {
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
      var url = backendServer + "/blog/categories";
      final response = await dio.get(url);
      List tList = new List(); 
      for (int i = 0; i < response.data.length; i++) {
        tList.add(response.data[i]);
      }
      setState(() {
        contentLoading = false;
        contents.addAll(tList);
        selectedCategory = contents[0]["id"];        
        this._getMoreData(page); 
      });
    } catch(e) {

    }
  }
  void _getMoreData(int index) async {
    if (!blogLoading) {
      setState(() {
        blogLoading = true;
      });
      var url = backendServer + "/blog_category/"+ selectedCategory.toString() +"?page=" + page.toString();
      print(url);
      try {
        final response = await dio.get(url);
        List tList = new List(); 
        for (int i = 0; i < response.data["data"].length; i++) {
          tList.add(response.data["data"][i]);
        }
        setState(() {
          blogLoading = false;
          blogCompleted = response.data["next_page_url"] == null ? true : false;
          blogs.addAll(tList);
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
                    "Sra, Blog",
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
                            selectedCategory = contents[index]["id"];
                            page = 1;
                            blogs = [];
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
                              width: selectedCategory == contents[index]["id"] ? 3 : 0,
                              color: Theme.of(context).primaryColor
                            )
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  contents[index]["name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${contents[index]['count']} posts",
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
                RecentPosts(blogs: blogs)
              ],
            )
          ),
          blogLoading ? Loader() : SizedBox(height: 10)
        ],
        controller: _sc,
      ) 
    );
  }
}
