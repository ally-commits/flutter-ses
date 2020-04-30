import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( 
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 150, 
      child:Center(
        child: JumpingDotsProgressIndicator(
          fontSize: 40.0,
        ),
      ),
    );
  }
}