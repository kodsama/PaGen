import 'package:flutter/material.dart';

import '../states.dart';


class SettingsWidget extends StatefulWidget {
  SettingsWidget({Key key}): super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}


class _SettingsState extends State<SettingsWidget> {
  String paTheme;
  double paScale;

  final int _paScaleLevels = 2;
  final List<String> _paThemes = [
    "Random",
    "Public",
    "Laundry",
    "Kitchen"
    ];
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyStatefulWidgetState data = MyStatefulWidget.of(context);
    paScale = data.paScale;
    paTheme = data.paTheme;
  }

  void sliderChange (double value) {
    setState(() {
      paScale = value;
      MyStatefulWidget.of(context).updatePaScale(value);
    });
  }

  void themeChange (String value) {
    setState(() {
      paTheme = value;
      MyStatefulWidget.of(context).updatePaTheme(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.2 * (MediaQuery.of(context).size.height),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'More passive or agressive today?',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.08,
                child: Text('Passive',
                  style: TextStyle(fontSize: 8.0,),
                  ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Slider(
                  min: 0,
                  max: this._paScaleLevels.toDouble(),
                  divisions: this._paScaleLevels,
                  label: 'Level',
                  value: paScale,
                  onChanged: (double value) { sliderChange(value); },
                  ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.11,
                child: Text('Aggressive',
                  style: TextStyle(fontSize: 8.0,),
                  ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text('Frustration source'),
              ),
              DropdownButton<String>(
                value: paTheme,
                items: this._paThemes
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                // icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: Colors.orange
                ),
                underline: Container(),
                onChanged:  (String value) { themeChange(value); },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
