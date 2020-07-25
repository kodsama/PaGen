import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../states.dart';

class QuoteWidget extends StatelessWidget {
  final Widget child;

  QuoteWidget({Key key, @required this.child}): super(key: key);

  void onPressed(BuildContext context) {
    MyStatefulWidget.of(context).pickQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // height: _chosenHeight,
        // width: MediaQuery.of(context).size.width,
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
        AutoSizeText(
          '$quote',
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.black
          ),
          minFontSize: 12,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 60), // Spacing
        Align(
          alignment: Alignment.centerRight,
          child: AutoSizeText(
            '- $source',
            style: TextStyle(
              fontSize: fontSize - 5,
              color: Colors.grey
            ),
            minFontSize: 12,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ]
    );
  }
}