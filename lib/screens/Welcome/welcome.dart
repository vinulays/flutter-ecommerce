import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      pages: [
        PageViewModel(
            title: "hi",
            bodyWidget: Column(
              children: [],
            )),
        PageViewModel(
            title: 'Page Two', bodyWidget: const Text('That\'s all folks'))
      ],
      next: Text("hi"),
      done: Text("DONe"),
      showNextButton: true,
      showDoneButton: true,
      onDone: () {},
    );
  }
}
