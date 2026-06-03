import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../states.dart';
import '../theme/app_theme.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/images/trollface.png',
            fit: BoxFit.contain,
            height: 36,
            width: 36,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              appLongName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w900,
                fontSize: 17,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
