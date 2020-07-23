import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({Key key}): super(key: key);

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
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
  }
}
