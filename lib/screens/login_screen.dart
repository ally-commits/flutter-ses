import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sra/screens/home_page.dart'; 
import 'package:sra/screens/loader.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Sra",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .2
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Student Empowerment System",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16
                      ),
                    ), 
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.width * 0.70,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[ 
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        ' " Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC" ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0, 
                          letterSpacing: .1,
                          wordSpacing: 1,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                    JumpingDotsProgressIndicator(
                      fontSize: 40.0,
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width, 
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomePage()
                        )
                      );
                    },
                    child: Container(
                      width: 300,
                      height: 70, 
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          bottomLeft: Radius.circular(35.0)
                        )
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0,),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35.0),
                                bottomLeft: Radius.circular(35.0)
                              ),
                              child: Image(
                                width: 70,
                                image: AssetImage('assets/images/google.png')
                              ),
                            ),
                          ),
                          Text(
                            "Google Sign In",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}