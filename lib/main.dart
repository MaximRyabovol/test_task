import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _mainWidgetAnimationController;
  Animation _mainWidgetFadeAnimation;

  AnimationController _progressBarAnimationController;
  Animation _progressBarAnimation;

  Size baseSize;

  @override
  void initState() {
    super.initState();
    _mainWidgetAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _mainWidgetFadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_mainWidgetAnimationController);

    _progressBarAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _progressBarAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_progressBarAnimationController);

    _mainWidgetAnimationController.addStatusListener(
      (status) {
        setState(() {
          print(status);
          if (status == AnimationStatus.completed) {
            _progressBarAnimationController.forward();
          }
        });
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseSize = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    _mainWidgetAnimationController.dispose();
    _progressBarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: FadeTransition(
          opacity: _mainWidgetFadeAnimation,
          child: GestureDetector(
            onTap: () {
              _mainWidgetAnimationController.forward();
            },
            child: SizedBox(
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: baseSize.width * 0.15,
                        height: baseSize.width * 0.15,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            AnimatedBuilder(
                              animation: _progressBarAnimation,
                              builder: (BuildContext context, Widget child) {
                                return Transform.rotate(
                                  angle: 2.4,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    backgroundColor: Colors.white30,
                                    value: _progressBarAnimation.value,
                                  ),
                                );
                              },
                            ),
                            Icon(
                              Icons.close,
                              color: Colors.white,
                              size: baseSize.width * 0.11,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: baseSize.width * 0.05,
                      ),
                      Text(
                        'Error',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
