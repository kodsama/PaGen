import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';

import '../states.dart';
import '../theme/app_theme.dart';
import 'slider.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsWidget> {
  static const int _paScaleLevels = 2;

  late String paTheme;
  late double paScale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncFromAppState();
  }

  void _syncFromAppState() {
    final data = MyStatefulWidget.of(context);
    paScale = data.paScale;
    paTheme = data.paTheme;
  }

  void _sliderChange(double value) {
    setState(() => paScale = value);
    MyStatefulWidget.of(context).updatePaScale(value);
  }

  void _themeChange(String value) {
    setState(() => paTheme = value);
    MyStatefulWidget.of(context).updatePaTheme(value);
  }

  @override
  Widget build(BuildContext context) {
    final themes = MyStatefulWidget.of(context).paThemes;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              FlutterI18n.translate(context, 'settings.pa'),
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: AppColors.inkMuted,
              ),
            ),
            const SizedBox(height: 10),
            _buildAggressionSlider(context),
            const SizedBox(height: 14),
            Text(
              FlutterI18n.translate(context, 'settings.theme'),
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: AppColors.inkMuted,
              ),
            ),
            const SizedBox(height: 8),
            _buildThemeDropdown(context, themes),
          ],
        ),
      ),
    );
  }

  Widget _buildAggressionSlider(BuildContext context) {
    const sliderHeight = 48.0;
    const paddingFactor = 0.2;

    return Container(
      height: sliderHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sliderHeight * 0.3),
        gradient: const LinearGradient(
          colors: [AppColors.mint, AppColors.coral],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          sliderHeight * paddingFactor,
          2,
          sliderHeight * paddingFactor,
          2,
        ),
        child: Row(
          children: [
            Text(
              FlutterI18n.translate(context, 'settings.p'),
              style: TextStyle(
                fontSize: sliderHeight * 0.2,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(width: sliderHeight * 0.1),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white.withValues(alpha: 0.45),
                  trackHeight: 4,
                  thumbShape: CustomSliderThumbCircle(
                    thumbRadius: sliderHeight * 0.4,
                    min: 0,
                    max: _paScaleLevels,
                    writeValue: false,
                  ),
                  overlayColor: Colors.white.withValues(alpha: 0.35),
                ),
                child: Slider(
                  min: 0,
                  max: _paScaleLevels.toDouble(),
                  divisions: _paScaleLevels,
                  value: paScale,
                  onChanged: _sliderChange,
                ),
              ),
            ),
            SizedBox(width: sliderHeight * 0.1),
            Text(
              FlutterI18n.translate(context, 'settings.a'),
              style: TextStyle(
                fontSize: sliderHeight * 0.2,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeDropdown(BuildContext context, List<String> themes) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8E4DC)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: themes.contains(paTheme) ? paTheme : themes.first,
            items: themes
                .map(
                  (theme) => DropdownMenuItem<String>(
                    value: theme,
                    child: Text(
                      theme,
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w700),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) _themeChange(value);
            },
          ),
        ),
      ),
    );
  }
}
