import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import '../widgets/add_quote.dart';

class AddQuoteScreen extends StatelessWidget {
  AddQuoteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: AddQuoteWidget(),
    );
  }
}