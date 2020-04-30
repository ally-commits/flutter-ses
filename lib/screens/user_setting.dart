import 'package:flutter/material.dart';
import 'package:sra/models/author_model.dart';

class UserSetting extends StatefulWidget {
  @override
  _UserSettingState createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  List<String> contents = ['Bookmarks','Privacy Policy','Notification','Settings','Logout'];
  _buildContent() {
    return Column(
      children: contents.map((content) => 
        ListTile(
          title: Text(
            content,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.0,
          ), 
        ),
      ).toList()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container( 
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.width * 0.60,
              margin: EdgeInsets.symmetric(horizontal: 20.0), 
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0)
                ),
                boxShadow: [BoxShadow(
                  color: Colors.black26.withOpacity(0.05),
                  offset: Offset(0.0,6.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.10
                )]
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 60.0),
                  Text(
                    john.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildContent()
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width * 0.30,
            left: MediaQuery.of(context).size.width * 0.375,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.white,
                  width: 5
                )
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: AssetImage(john.imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}