import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'home.dart';
import '../states.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 15.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      //descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: postItColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: appColor,
      showSkipButton: true,
      showNextButton: true,
      next: const Icon(Icons.arrow_forward),
      skip: const Text('Skip'),
      done: const Text('Shoot!', style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      pages: [
        PageViewModel(
          title: 'You filthy thing! 💩',
          body:
              'You are bad... real bad...\nbad enough to use this insult generator!',
          image: Center(
              child: Image.asset('assets/images/trollface.png', height: 175.0)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Select how agressive you feel 🤬',
          body: 'Use the slider! \n(yes like the one above) 😂',
          image: Center(
              child: Image.asset('assets/images/onboard_slider.png',
                  height: 175.0)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'A specific frustration in mind? 😠',
          body: 'Select it from here with your 🖕!',
          image: Center(
              child: Image.asset('assets/images/onboard_theme.png',
                  height: 175.0)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Tap here and get tons of 💩!',
          body: 'Bang, here you go!\nTap it baby! ',
          image: Center(
              child:
                  Image.asset('assets/images/onboard_note.png', height: 175.0)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'If you are real bad...🤦',
          body: 'Drop your own 💩 or rate them by tapping there! 🖖',
          image: Center(
              child:
                  Image.asset('assets/images/onboard_menu.png', height: 175.0)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'So long suckers! 🚀',
          body: ''' Don't forget to give (constructive) feedback
          \n\n\n (Or buy the useless author a cup of tea 🍵)
          (https://www.buymeacoffee.com/kodsama)''',
          image: Center(
              child:
                  Image.asset('assets/images/coffee_mug.png', height: 175.0)),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
