import 'package:flutter/material.dart';

class QuoteBar extends StatefulWidget {
  QuoteBar();

  @override
  _QuoteBarState createState() => _QuoteBarState();
}

class _QuoteBarState extends State<QuoteBar> {
  final String quote = 'Quote goes here';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.65 * (MediaQuery.of(context).size.height - 80),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(quote),
        ], // children
      ), // Column
    ); // Container
  }
}
