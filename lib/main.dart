import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _mainWidgetAnimationController;
  Animation _mainWidgetFadeAnimation;

  @override
  void initState() {
    super.initState();
    _mainWidgetAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _mainWidgetFadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_mainWidgetAnimationController);
  }

  @override
  void dispose() {
    super.dispose();
    _mainWidgetAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.green,
          child: FadeTransition(
            opacity: _mainWidgetFadeAnimation,
            child: GestureDetector(
              onTap: () {
                _mainWidgetAnimationController.forward();
              },
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
