import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_1/generated/locale_keys.g.dart';
import 'package:flutter_application_1/trasnlationbut.dart';


class Animationn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: LocaleKeys.Animation.tr(),
      theme: ThemeData.dark(), 
      home: TypingAnimation(),
    );
  }
}

class TypingAnimation extends StatefulWidget {
  @override
  _TypingAnimationState createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation> {
  String _displayedCode = '';
  final String _fullCode = "void main() {\n  runApp(MyApp());\n}\n// print LOGO";
  int _charIndex = 0;
  Timer? _timer;
  bool _showCard = true;
  bool _showLogo = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    _timer = Timer.periodic(Duration(milliseconds: 100), _typeCode);
  }

  void _typeCode(Timer timer) {
    if (_charIndex < _fullCode.length) {
      setState(() {
        _displayedCode = _fullCode.substring(0, _charIndex);
        _charIndex++;
      });
    } else {
      _timer!.cancel();
      setState(() {
        _showCard = false;
        _showLogo = true;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Анимация Печатания Кода'),
        actions: [
            TranslationButton(),
          ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_showCard)
              AnimatedOpacity(
                opacity: _showCard ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          for (var i = 0; i < _displayedCode.length; i++)
                            TextSpan(
                              text: _displayedCode[i],
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'monospace',
                                fontSize: 16.0,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (_showLogo)
              AnimatedOpacity(
                opacity: _showLogo ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Image.asset('assets/image/myapp.png', width: 200),
              ),
          ],
        ),
      ),
    );
  }
}