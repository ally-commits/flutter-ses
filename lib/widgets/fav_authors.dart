import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sra/models/author_model.dart';
import 'package:sra/screens/author_screen.dart';
import 'package:sra/screens/loader.dart';
import 'package:sra/utils/var.dart';

class FavAuthors extends StatefulWidget {
  @override
  _FavAuthorsState createState() => _FavAuthorsState();
}

class _FavAuthorsState extends State<FavAuthors> {
  static int page = 0;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List users = new List();
  final dio = new Dio();

  @override
  void initState() {
    this._getMoreData(page);
    super.initState(); 
  }
 
  @override
  void dispose() { 
    super.dispose();
  }
  void _getMoreData(int index) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      var url = backendServer + "/get-students";
      try {
        print(url);
        final response = await dio.get(url); 
        List tList = new List();

        for (int i = 0; i < response.data.length; i++) {
          tList.add(response.data[i]); 
        } 
        setState(() {
          isLoading = false;
          users.addAll(tList);
          print("done");
          page++; 
        });
      } catch(e) {
        print(e);
      }
    }
  }
  @override
  Widget build(BuildContext context) { 
    return  Container(
      height: 80.0, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AuthorScreen(
                    id: users[index]["id"]
                  )
                )
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    image: NetworkImage(users[index]["path"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}