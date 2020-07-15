import 'package:flutter/material.dart';
import 'bar_quote.dart';


class BottomBar extends StatelessWidget {
  BottomBar();

  @override
  Widget build(BuildContext context) {
    final String buttonText = 'Fire!';
    return Container(
      height: 0.10 * (MediaQuery.of(context).size.height - 80),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {},
            padding: const EdgeInsets.all(0.0),
            textColor: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFFCD2C24),
                    Color(0xFFF2836B),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                '   Fire!   ',
                style: TextStyle(fontSize: 20)
              ),
            ), // child of RaisedButton
          ), // RaisedButton
        ], // children of Column
      ), // Column
    ); // Container
  }
}
