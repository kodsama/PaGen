import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  final String title = 'Passive Agressive Generator';

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
            'assets/images/trollface.png',
            fit: BoxFit.contain,
            height: 60,
            ),
            Expanded(
              child: AutoSizeText(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  ),
                minFontSize: 12,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
  }
}
