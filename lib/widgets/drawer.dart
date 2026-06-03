import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/add_quote.dart';
import '../screens/onboarding.dart';
import '../states.dart';
import '../theme/app_theme.dart';
import '../utils/app_logger.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              decoration: const BoxDecoration(color: AppColors.lemon),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/trollface.png',
                    height: 48,
                    width: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    FlutterI18n.translate(context, 'home.god_mode'),
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
            _DrawerTile(
              icon: Icons.school_outlined,
              label: FlutterI18n.translate(context, 'home.view_demo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => OnboardScreen()),
                );
              },
            ),
            _DrawerTile(
              icon: Icons.edit_note_outlined,
              label: FlutterI18n.translate(context, 'home.add_quote'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => AddQuoteScreen()),
                );
              },
            ),
            _DrawerTile(
              icon: Icons.thumb_up_outlined,
              label: FlutterI18n.translate(context, 'home.thumb_up'),
              onTap: () {
                _gradeAndClose(context, 1);
              },
            ),
            _DrawerTile(
              icon: Icons.thumb_down_outlined,
              label: FlutterI18n.translate(context, 'home.thumb_down'),
              onTap: () {
                _gradeAndClose(context, -1);
              },
            ),
            _DrawerTile(
              icon: Icons.local_cafe_outlined,
              label: FlutterI18n.translate(context, 'home.buy_tea'),
              onTap: _launchBuyMeCoffeeURL,
            ),
          ],
        ),
      ),
    );
  }

  void _gradeAndClose(BuildContext context, int delta) {
    MyStatefulWidget.of(context).bumpQuoteGrade(delta);
    Navigator.pop(context);
  }

  Future<void> _launchBuyMeCoffeeURL() async {
    final Uri url = Uri.parse('https://www.buymeacoffee.com/kodsama');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      AppLogger.warning('Could not open Buy Me a Coffee URL: $url');
    }
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.coral),
      title: Text(
        label,
        style: GoogleFonts.nunito(fontWeight: FontWeight.w700),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }
}
