import 'package:flutter/material.dart';
import 'dart:math';

Map<int, Color> color = {
  50:Color.fromRGBO(4,131,184, .1),
  100:Color.fromRGBO(4,131,184, .2),
  200:Color.fromRGBO(4,131,184, .3),
  300:Color.fromRGBO(4,131,184, .4),
  400:Color.fromRGBO(4,131,184, .5),
  500:Color.fromRGBO(4,131,184, .6),
  600:Color.fromRGBO(4,131,184, .7),
  700:Color.fromRGBO(4,131,184, .8),
  800:Color.fromRGBO(4,131,184, .9),
  900:Color.fromRGBO(4,131,184, 1),
};
final MaterialColor appColor = MaterialColor(0xFFEFF294, color);
final MaterialColor postItColor = MaterialColor(0xFFF2EFBD, color);

final String appShortName = 'PAGen';
final String appLongName = 'Passive Agressive GENerator';

List<String> _quotes = [
    '''
    “Love without sacrifice is like theft”
    ― Nassim Nicholas Taleb
    ''',
    '''
    “When introverts are in conflict with each other...it may require a map in order to follow all the silences, nonverbal cues and passive-aggressive behaviors!”
    ― Adam S. McHugh 
    ''',
    '''
    “Anger's like a battery that leaks acid right out of me
    And it starts from the heart 'til it reaches my outer me”
    ― Criss Jami, Venus in Arms 
    ''',
    '''
    “Lingering, bottled-up anger never reveals the 'true colors' of an individual. It, on the contrary, becomes all mixed up, rotten, confused, forms a highly combustible, chemical compound then explodes as something foreign, something very different than one's natural self.”
    ― Criss Jami, Healology 
    ''',
    '''
    “To let friendship die away by negligence and silence is certainly not wise. It is voluntarily to throw away one of the greatest comforts of this weary pilgrimage." ~Samuel Johnson”
    ― Edward M. Hallowell
    ''',
    ];

class MyStatefulWidget extends StatefulWidget {
  final Widget child;

  const MyStatefulWidget({Key key, @required this.child}) : super(key: key);

  static MyStatefulWidgetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>().data;
  }

  @override
  State<StatefulWidget> createState() {
    return MyStatefulWidgetState();
  }
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  String _quote = _quotes[Random().nextInt(_quotes.length)];
  int _counterValue = 0;

  String get quote => _quote;
  int get counterValue => _counterValue;

  void pickRandomQuote() {
    setState(() {
      _quote = _quotes[Random().nextInt(_quotes.length)];
    });
  }

  void addCounterBy1() {
    setState(() {
      _counterValue += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      child: widget.child,
      data: this,
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final MyStatefulWidgetState data;

  MyInheritedWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}