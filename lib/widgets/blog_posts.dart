import 'package:dio/dio.dart'; 
import 'package:flutter/material.dart';
import 'package:sra/loaders/home_blog_loader.dart';
import 'package:sra/screens/blog_post.dart';
import 'package:sra/screens/loader.dart';
import 'package:sra/utils/var.dart';

class BlogPosts extends StatefulWidget {
  @override
  _BlogPostsState createState() => _BlogPostsState();
}

class _BlogPostsState extends State<BlogPosts> {
  bool isLoading = true;
  List blogs = new List();
  final dio = new Dio();

  @override
  void initState() {
    this._getData();
    super.initState(); 
  }
  void _getData() async { 
    var url = backendServer + "/blogs";
    try {
      print(url);
      final response = await dio.get(url); 
      List tList = new List();  
      for (int i = 0; i < response.data["data"].length; i++) {
        tList.add(response.data["data"][i]); 
      } 
      setState(() {
        isLoading = false;
        blogs.addAll(tList);
        print("done"); 
      });
    } catch(e) {
      print(e);
    } 
  }
  @override
  Widget build(BuildContext context) { 
    return Column(
      children: <Widget>[
        isLoading ?
        HomeBlogLoader() : 
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          height: MediaQuery.of(context).size.width * 0.90, 
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: blogs.length,
            itemBuilder: (BuildContext context, int index) { 
              return GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlogPost(
                        id: blogs[index]["id"]
                      )
                    )
                  )
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0,top: 20.0, bottom: 20.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.width * 0.90,
                        decoration: BoxDecoration( 
                          borderRadius: BorderRadius.circular(14.0),
                          color: Colors.white,
                          boxShadow: [BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0,4.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10
                          )]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14.0), 
                          child: Image(
                            image: NetworkImage(blogs[index]["path"]),
                            fit: BoxFit.cover,
                          ),
                        )
                      ),
                      Positioned(
                        bottom: 10.0,
                        left: 10.0, 
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: Text(
                                blogs[index]["title"],  
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.6,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 10.0,
                                  backgroundImage: NetworkImage(blogs[index]["studentPath"])
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  blogs[index]["studentName"], 
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0
                                  )
                                ), 
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
                            Icon(
                              Icons.timer,
                              size: 10.0,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              blogs[index]["published_date"], 
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              )
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10.0,
                        right: 10.0,
                        child: Icon(
                          Icons.bookmark,
                          size: 26.0,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
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