import 'package:flutter/material.dart';

AppBar BuildAppBar(String title, double height_px) {
  AppBar bar = AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
        'images/trollface.png',
        fit: BoxFit.contain,
        height: height_px,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(title)
        ), // Container
      ], // children
    ), // Row
  ); // AppBar
  return bar;
}
