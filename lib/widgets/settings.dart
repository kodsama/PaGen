import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../states.dart';
import 'slider.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsWidget> {
  late String paTheme;
  late double paScale;

  final int _paScaleLevels = 2;
  final List<String> _paThemes = ["Random", "Public", "Laundry", "Kitchen"];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyStatefulWidgetState data = MyStatefulWidget.of(context);
    paScale = data.paScale;
    paTheme = data.paTheme;
  }

  void sliderChange(double value) {
    setState(() {
      paScale = value;
      MyStatefulWidget.of(context).updatePaScale(value);
    });
  }

  void themeChange(String value) {
    setState(() {
      paTheme = value;
      MyStatefulWidget.of(context).updatePaTheme(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.2 * (MediaQuery.of(context).size.height),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            FlutterI18n.translate(context, 'settings.pa'),
          ),
          SizedBox(height: 10),
          _sliderCreate(),
          _sourceCreate(),
        ],
      ),
    );
  }

  Row _sourceCreate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Text(FlutterI18n.translate(context, 'settings.theme')),
        ),
        DropdownButton<String>(
          value: paTheme,
          items: _paThemes.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.orange),
          underline: Container(),
          onChanged: (String? value) {
            if (value != null) themeChange(value);
          },
        ),
      ],
    );
  }

  Container _sliderCreate() {
    double paddingFactor = .2;
    double sliderHeight = 48;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: sliderHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(sliderHeight * .3),
        ),
        gradient: const LinearGradient(
            colors: [
              Colors.orange,
              Colors.red,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 1.00),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            sliderHeight * paddingFactor, 2, sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, 'settings.p'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: sliderHeight * .2,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: sliderHeight * .1,
            ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withValues(alpha: 1),
                    inactiveTrackColor: Colors.white.withValues(alpha: .5),
                    trackHeight: 4.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: sliderHeight * .4,
                      min: 0,
                      max: _paScaleLevels,
                      writeValue: false,
                    ),
                    overlayColor: Colors.white.withValues(alpha: .4),
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.red.withValues(alpha: .7),
                  ),
                  child: Slider(
                    max: _paScaleLevels.toDouble(),
                    divisions: _paScaleLevels,
                    // label: 'Level',
                    value: paScale,
                    onChanged: (double value) {
                      sliderChange(value);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: sliderHeight * .1,
            ),
            Text(
              FlutterI18n.translate(context, 'settings.a'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: sliderHeight * .2,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
