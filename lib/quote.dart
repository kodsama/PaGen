import 'package:flutter/material.dart';

import 'states.dart';

class QuoteContainer extends StatelessWidget {
  final Widget child;

  QuoteContainer({
    Key key,
    @required this.child,
  })  : super(key: key);

  void onPressed(BuildContext context) {
    MyStatefulWidget.of(context).pickQuote();
  }

  @override
  State<StatefulWidget> createState() {
    return QuoteTextState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 0.8 * (MediaQuery.of(context).size.height - 80),
        width: MediaQuery.of(context).size.width,
        color: postItColor,
        child: RaisedButton(
          color: postItColor,
          onPressed: (){
            onPressed(context);
          },
          child: child,
        ),
      ),
    );
  }
}

class QuoteText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuoteTextState();
  }
}

class QuoteTextState extends State<QuoteText> {
  String quote;
  String source;
  double fontSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyStatefulWidgetState data = MyStatefulWidget.of(context);
    quote = data.quote;
    source = data.source;
    fontSize = 20.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column (
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Text(
          '$quote',
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 60), // Spacing
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '- $source',
            style: TextStyle(
              fontSize: fontSize - 5,
              color: Colors.grey,
            ),
          ), // Text
        ), // Align
      ] // children
    ); // Column
  }
}