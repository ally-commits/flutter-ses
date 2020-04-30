import 'package:dio/dio.dart'; 
import 'package:flutter/material.dart';
import 'package:sra/screens/loader.dart';
import 'package:sra/utils/var.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class BlogPost extends StatefulWidget {
  @override
  final int id;

  BlogPost({this.id});
  _BlogPostState createState() => _BlogPostState();
}

class _BlogPostState extends State<BlogPost> {
  List blog = new List();
  final dio = new Dio();  
  static int page = 1;
  bool isLoading = true;
  @override

  void initState()  {
    this._getData();
  }
  @override
  void _getData() async {
    var url = backendServer + "/blog_post/" + widget.id.toString();
    try {
      print(url);
      final response = await dio.get(url); 
      setState(() { 
        blog = response.data; 
        isLoading = false; 
        print("done"); 
      });
    } catch(e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) { 
    print(blog);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: 
        isLoading ?
        Center(child: Loader()) :
        ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(  
                    height: MediaQuery.of(context).size.height * 0.45, 
                    child: ClipRRect(
                      child: Image(
                        image: NetworkImage(blog[0]["path"]), 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned( 
                    bottom: 0,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.0),
                          topRight: Radius.circular(60.0)
                        ),
                      ),
                      child: SizedBox(width: 1),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon : Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 25,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Icon(
                            Icons.bookmark_border,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container( 
              decoration: BoxDecoration( 
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      blog[0]["title"],
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              blog[0]["published_date"],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 20.0),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              "${blog[0]['views']} Views",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20.0),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.thumb_up,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              "${blog[0]['likes']} Likes",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(blog[0]["studentPath"]),
                          radius: 22.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          blog[0]["studentName"],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Html(
                      data: """
                        ${blog[0]['content']}
                      """,
                      linkStyle: const TextStyle(
                        color: Colors.blueAccent, 
                      ),
                      onLinkTap: (url) {
                        print("Opening $url...");
                      },
                      onImageTap: (src) {
                        print(src);
                      },
                      customRender: (node, children) {
                        if (node is dom.Element) {
                          switch (node.localName) {
                            case "img":
                              return null;
                          }
                        }
                        return null;
                      },
                      customTextAlign: (dom.Node node) {
                        if (node is dom.Element) {
                          switch (node.localName) {
                            case "p":
                              return TextAlign.justify; 
                          }
                        }
                        return null;
                      },
                      customTextStyle: (dom.Node node, TextStyle baseStyle) {
                        if (node is dom.Element) {
                          switch (node.localName) {
                            case "p":
                              return baseStyle.merge(TextStyle(height: 1.8, fontSize: 16));
                          }
                        }
                        return baseStyle;
                      },
                    ),
                    SizedBox(height: 20.0)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}