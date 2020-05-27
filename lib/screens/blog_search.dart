import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sra/loaders/blog_loader.dart';
import 'package:sra/screens/loader.dart';
import 'package:sra/utils/var.dart';
import 'package:sra/widgets/recent_posts.dart';

class BlogSearch extends StatefulWidget {
  @override
  _BlogSearchState createState() => _BlogSearchState();
}

class _BlogSearchState extends State<BlogSearch> {
  final textFieldValueHolder = TextEditingController();
  String result = '';
  final dio = new Dio();

  static int selectedCategory;

  ScrollController _sc = new ScrollController();

  bool blogLoading = false;
  bool blogCompleted = false; 
  bool _noData = false;

  List blogs = new List(); 

   void initState() {
    this._getMoreData();
    super.initState();
  }
  getTextInputData() {
    setState(() {
      result = textFieldValueHolder.text;
    });
  }
  void _getMoreData() async {
    if (!blogLoading) {
      setState(() {
        blogLoading = true;
        blogs = [];
        _noData = false;
      });
      var url = backendServer + "/blogs/search?search=" + result;
      print(url);
      try {
        final response = await dio.get(url);
        List tList = new List(); 
        for (int i = 0; i < response.data.length; i++) {
          tList.add(response.data[i]);
        }
        if(response.data.length == 0) {
          setState(() {
            _noData = true;
            blogCompleted = true;
            blogLoading = false;
          });
        } else {
          setState(() {
            blogLoading = false; 
            blogs.addAll(tList); 
          });
        }
      } catch(e) {
        print(e);
      }
    }
  }
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 70, 
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.005),
                  offset: Offset(0.0,10.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.5
                )]
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(   
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.black,
                      )
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.86,
                      child: TextField(
                        controller: textFieldValueHolder,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search here...'
                        ),
                        autocorrect: false,
                        onChanged: (value) => {
                          setState(() {
                            result = value; 
                            _getMoreData();
                            print(value);
                          })
                        },
                        autofocus: true,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    !_noData ? 
                      RecentPosts(blogs: blogs) :
                      Center(child: Text(
                        "No Data Found..",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      )),
                    blogCompleted ? 
                      Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            "______________________",
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.grey.withOpacity(0.6)
                            )
                          ),
                        ),
                      ) : BlogLoader()
                  ], 
                ),
              ) 
            ],
          ),
        ),
      ),
    );
  }
}