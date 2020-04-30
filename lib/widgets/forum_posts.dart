import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sra/models/post_model.dart';
import 'package:sra/screens/forum_post.dart';
import 'package:sra/screens/loader.dart'; 

class Posts extends StatefulWidget {
  final List questions;
  Posts({this.questions});
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    print(questions);
    return 
    widget.questions.length == 0 ?
    Center(child: Loader()) :
    Column(
      children: widget.questions.map((question) =>
          GestureDetector( 
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ForumPost(
                    id: question["id"]
                  )
                )
              );
            },
            child: Container(
              height: 180,
              margin: EdgeInsets.all(15.0),
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
                padding: EdgeInsets.all(15.0),
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 70,  
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  question["avatar"] == null 
                                  ? "https://f0.pngfuel.com/png/178/595/black-profile-icon-illustration-user-profile-computer-icons-login-user-avatars-png-clip-art-thumbnail.png"
                                  : question["avatar"]
                                ),
                                radius: 22,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container( 
                                      width: MediaQuery.of(context).size.width * 0.65,
                                      child: Text(
                                        "${question['title'].substring(0,30)} ..", 
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .4
                                        ),
                                      ),
                                    ), 
                                    SizedBox(height: 2.0),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          question["name"], 
                                          style: TextStyle(
                                            color: Colors.grey.withOpacity(0.6)
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          "${question["created_at"]}",
                                          style: TextStyle(
                                            color: Colors.grey.withOpacity(0.6)
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
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
                    Container(
                      height: 50, 
                      child: Center(
                        child: Text(
                          "${question['description'].substring(0,80)}..", 
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.8),
                            fontSize: 16,
                            letterSpacing: .3
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.thumb_up,
                              color: Colors.grey.withOpacity(0.6),
                              size: 22,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              "${question['likes']} votes", 
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.6),
                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.email,
                              color: Colors.grey.withOpacity(0.6),
                              size: 16,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              "${question['replies']} replies", 
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.6)
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.panorama_fish_eye,
                              color: Colors.grey.withOpacity(0.6),
                              size: 18,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              "${question['views']} views",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.6)
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ).toList()
    );
  }
}