import 'package:flutter/material.dart';

import '../states.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';
import '../widgets/home_actions.dart';
import '../widgets/quote.dart';
import '../widgets/settings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = MyStatefulWidget.watch(context);

    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SettingsWidget(),
              const SizedBox(height: 12),
              Expanded(
                child: QuoteWidget(
                  child: QuoteText(
                    key: ValueKey<int>(app.quoteRevision),
                    quote: app.quote,
                    onPickQuote: app.state.pickQuote,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              HomeActions(key: ValueKey<int>(app.quoteRevision)),
            ],
          ),
        ),
      ),
    );
  }
}
