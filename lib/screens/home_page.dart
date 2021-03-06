import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sra/screens/blog_screen.dart';
import 'package:sra/screens/forum_screen.dart';
import 'package:sra/screens/home_screen.dart';
import 'package:sra/screens/user_setting.dart'; 

class HomePage extends StatefulWidget {
  final int index;
  final GoogleSignInAccount user;
  HomePage({this.index, this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    BlogScreen(),
    ForumScreen(),
    UserSetting()
  ]; 
  Widget _buildBody() {
    if(_selectedIndex == 0) {
      return HomeScreen();
    } else if(_selectedIndex == 1) {
      return BlogScreen();
    } else if(_selectedIndex == 2) {
      return ForumScreen();
    } else if(_selectedIndex == 3) {
      return UserSetting(user: widget.user);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(  
        child: _buildBody()
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.05))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 20,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor:Theme.of(context).primaryColor,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.content_copy,
                    text: 'Blog',
                  ),
                  GButton(
                    icon: Icons.question_answer,
                    text: 'Forum',
                  ), 
                  GButton(
                    icon: Icons.person,
                    text: 'User',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}