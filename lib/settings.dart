import 'package:flutter/material.dart';

import 'states.dart';


class Settings extends StatefulWidget {
  Settings();

  @override
  _SettingsState createState() => _SettingsState();
}


class _SettingsState extends State<Settings> {
  String pa_theme;
  double pa_scale;

  final List<String> _pa_scales = [
    "Passive",
    "Passive-agressive",
    "Agressive",
  ];
  final int _pa_scale_levels = 2;
  final List<String> _pa_themes = [
    "Random",
    "Public",
    "Laundry",
    "Kitchen"
    ];
  
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyStatefulWidgetState data = MyStatefulWidget.of(context);
    pa_scale = data.pa_scale;
    pa_theme = data.pa_theme;
  }

  void sliderChange (double value) {
    setState(() {
      pa_scale = value;
      MyStatefulWidget.of(context).updatePaScale(value);
    });
  }

  void themeChange (String value) {
    setState(() {
      pa_theme = value;
      MyStatefulWidget.of(context).updatePaTheme(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.2 * (MediaQuery.of(context).size.height - 80),
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
                  max: this._pa_scale_levels.toDouble(),
                  divisions: this._pa_scale_levels,
                  label: 'Level',
                  value: pa_scale,
                  onChanged: (double value) { sliderChange(value); },
                  ), // Slider
              ), // Container
              Container(
                width: MediaQuery.of(context).size.width * 0.11,
                child: Text('Aggressive',
                  style: TextStyle(fontSize: 8.0,),
                  ),
              ),
            ], // children
          ), // Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text('Frustration source'),
              ),
              DropdownButton<String>(
                value: pa_theme,
                items: this._pa_themes
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
              ), // DropdownButton
            ], // children
          ), // Row
        ], // children
      ), // Column
    ); // Container
  }
}
