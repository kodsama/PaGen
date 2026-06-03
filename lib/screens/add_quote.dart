import 'package:flutter/material.dart';

import '../widgets/add_quote.dart';
import '../widgets/appbar.dart';

class AddQuoteScreen extends StatelessWidget {
  const AddQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: AddQuoteWidget(),
    );
  }
}
