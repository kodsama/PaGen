import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  BottomBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.10 * (MediaQuery.of(context).size.height - 80),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Here goes a button'),
        ], // children
      ), // Column
    ); // Container
  }
}
