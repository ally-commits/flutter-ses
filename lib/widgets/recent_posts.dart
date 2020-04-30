import 'package:sra/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:sra/screens/blog_post.dart';

class RecentPosts extends StatefulWidget {
  final List blogs;

  RecentPosts({this.blogs});
  @override
  _RecentPostsState createState() => _RecentPostsState();
}

class _RecentPostsState extends State<RecentPosts> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.blogs.map((blog) =>
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlogPost(
                    id: blog["id"]
                  )
                )
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 15.0),
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration( 
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Color(0xFFFAFAFA),
                  offset: Offset(0.0,10.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.5
                )]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.22,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image(
                          image: NetworkImage(blog["path"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.66, 
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(blog["studentPath"]),
                              ),
                              SizedBox(width: 10.0,),
                              Text(
                                blog["studentName"], 
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Container( 
                            height: 65,
                            child: Text(
                              blog["title"],
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.timer,
                                    color: Colors.grey,
                                    size: 12.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    blog["published_date"],
                                    style: TextStyle(
                                      color: Colors.grey,
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
                                    size: 12.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    "${blog['views']} Views",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ).toList()
      ),
    );
  }
}