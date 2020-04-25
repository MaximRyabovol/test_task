import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
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
  Animation _progressBarAppearingAnimation;
  Animation _progressBarFillingAnimation;
  Animation _progressBarErrorsLableAndTitleAppearing;

  Size baseSize;

  @override
  void initState() {
    super.initState();
    _mainWidgetAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

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

    _mainWidgetFadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_mainWidgetAnimationController);

    _progressBarAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1080));

    _progressBarAppearingAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressBarAnimationController,
        curve: Interval(
          0.0,
          0.185,
        ),
      ),
    );

    _progressBarFillingAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _progressBarAnimationController,
      curve: Interval(0.185, 0.75),
    ));

    _progressBarErrorsLableAndTitleAppearing =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _progressBarAnimationController,
      curve: Interval(0.75, 1.0),
    ));
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
              SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle(statusBarColor: Colors.transparent));
            },
            child: Container(
              color: Colors.black,
              child: Center(
                child: AnimatedBuilder(
                  animation: _progressBarAnimationController,
                  builder: (BuildContext context, Widget child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Transform.rotate(
                              angle: 2.4,
                              child: Container(
                                width: (_progressBarAppearingAnimation.value *
                                    (baseSize.width * 0.15)),
                                height: _progressBarAppearingAnimation.value *
                                    (baseSize.width * 0.15),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  backgroundColor: Colors.white30,
                                  value: _progressBarFillingAnimation.value,
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: _progressBarErrorsLableAndTitleAppearing
                                  .value,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: baseSize.width * 0.11,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: baseSize.width * 0.05,
                        ),
                        Opacity(
                          opacity:
                              _progressBarErrorsLableAndTitleAppearing.value,
                          child: Text(
                            'Error',
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
