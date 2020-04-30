import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:sra/models/post_model.dart';
import 'package:sra/screens/loader.dart';
import 'package:sra/utils/var.dart'; 

class ForumPost extends StatefulWidget {
  @override
  final int id;
  ForumPost({this.id});
  _ForumPostState createState() => _ForumPostState();
}

class _ForumPostState extends State<ForumPost> {
  List question = new List();
  List replies = new List();
  final dio = new Dio();  
  ScrollController _sc = new ScrollController();

  static int page = 1;
  bool replyCompleted = false;
  bool isLoading = true;
  @override

  void initState()  {
    this._getData(page);
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent && !replyCompleted) {
        _getData(page);
      }
    });
  }
  @override
  void _getData(int index) async {
    var url = backendServer + "/question/" + widget.id.toString() + "?page=" + index.toString();
    try {
      print(url);
      final response = await dio.get(url); 
      List tList = new List(); 
      for (int i = 0; i < response.data["replies"]["data"].length; i++) {
        tList.add(response.data["replies"]["data"][i]);
      }
      setState(() { 
        question = response.data["question"];  
        replies.addAll(tList);
        isLoading = false; 
        replyCompleted = response.data["replies"]["next_page_url"] == null ? true : false;
        page++;
        print("done"); 
      });
    } catch(e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: 
        isLoading ?
        Center(child: Loader()) :
        ListView(
          children: <Widget>[
            Container( 
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
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
                  SizedBox(width: 5.0),
                  Text(
                    "View Post",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  )
                ],
              ),
            ),
            Container( 
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [BoxShadow(
                  color: Colors.black26.withOpacity(0.05),
                  offset: Offset(0.0,6.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.10
                )]
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  question[0]["avatar"] == null 
                                  ? "https://f0.pngfuel.com/png/178/595/black-profile-icon-illustration-user-profile-computer-icons-login-user-avatars-png-clip-art-thumbnail.png"
                                  : question[0]["avatar"]
                                ),
                                radius: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(  
                                      child: Text(
                                        question[0]["name"],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .4
                                        ),
                                      ),
                                    ), 
                                    SizedBox(height: 2.0),
                                    Text(
                                      "${question[0]["created_at"]}",
                                      style: TextStyle(
                                        color: Colors.grey
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Icon(
                            Icons.bookmark,
                            color: Colors.grey.withOpacity(0.6),
                            size: 26,
                          ) 
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        question[0]["title"], 
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ), 
                    Html(
                      data: """
                        ${question[0]["description"]}
                      """, 
                      customTextStyle: (dom.Node node, TextStyle baseStyle) {
                        if (node is dom.Element) {
                          switch (node.localName) {
                            case "p":
                              return baseStyle.merge(TextStyle(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 17, 
                                letterSpacing: .2
                              ));
                          }
                        }
                        return baseStyle;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.thumb_up,
                                color: Colors.grey.withOpacity(0.5),
                                size: 22,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                "${question[0]['likes']} likes", 
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.5), 
                                ),
                              )
                            ],
                          ), 
                          SizedBox(width: 15.0),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.grey.withOpacity(0.5),
                                size: 18,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                "${question[0]['views']} views", 
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.5),
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
              child: Text(
                "Replies (${question[0]['replies']})", 
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Column(
              children: replies.map((reply) => 
                Container( 
                  margin: EdgeInsets.only(left:15.0, right: 15.0, top: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [BoxShadow(
                      color: Colors.black26.withOpacity(0.03),
                      offset: Offset(0.0,6.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.10
                    )],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      reply["userImage"] == null 
                                      ? "https://f0.pngfuel.com/png/178/595/black-profile-icon-illustration-user-profile-computer-icons-login-user-avatars-png-clip-art-thumbnail.png"
                                      : question[0]["avatar"]
                                    ),
                                    radius: 18,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(  
                                          child: Text(
                                            reply["userName"],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: .4
                                            ),
                                          ),
                                        ), 
                                        SizedBox(height: 2.0),
                                        Text(
                                          "${reply["created_at"]}",
                                          style: TextStyle(
                                            color: Colors.grey.withOpacity(0.4)
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ), 
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Html(
                            data: """
                              ${reply['answer_content']}
                            """, 
                            customTextStyle: (dom.Node node, TextStyle baseStyle) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case "p":
                                    return baseStyle.merge(TextStyle(
                                      color: Colors.black.withOpacity(0.25),
                                      fontSize: 16, 
                                    ));
                                }
                              }
                              return baseStyle;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[ 
                            Icon(
                              Icons.thumb_up, 
                              color: Colors.grey.withOpacity(0.5),
                              size: 20,
                            ), 
                            SizedBox(width: 5.0),
                            Text(
                              "${reply['likes']} likes",
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.5)
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                )
              ).toList(),
            ),
            replyCompleted ? Center(
              child: Text(
                "----------------",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.grey.withOpacity(0.6)
                ),
              )
            ) : Loader()
          ],
          controller: _sc, 
        ),
      ),
    );
  }
}