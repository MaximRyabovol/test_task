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

  AnimationController _bottomSheetAnimationController;
  Animation _bottomSheetAnimation;

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

    _progressBarAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _bottomSheetAnimationController.forward();
      }
    });

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

    _bottomSheetAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 420),
    );

    _bottomSheetAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_bottomSheetAnimationController);
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
    _bottomSheetAnimationController.dispose();
    super.dispose();
  }

  void startAnimation() async {
    if (_bottomSheetAnimationController.status == AnimationStatus.completed) {
      await _bottomSheetAnimationController.reverse();
      _progressBarAnimationController.reset();
      await _mainWidgetAnimationController.reverse();
    } else {
      _mainWidgetAnimationController.forward();
    }
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
              startAnimation();
            },
            child: Container(
              color: Colors.black,
              child: AnimatedBuilder(
                animation: _progressBarAnimationController,
                builder: (BuildContext context, Widget child) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Transform.rotate(
                                  angle: 2.4,
                                  child: Container(
                                    width:
                                        (_progressBarAppearingAnimation.value *
                                            (baseSize.width * 0.11)),
                                    height:
                                        _progressBarAppearingAnimation.value *
                                            (baseSize.width * 0.11),
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                      backgroundColor: Colors.white30,
                                      value: _progressBarFillingAnimation.value,
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity:
                                      _progressBarErrorsLableAndTitleAppearing
                                          .value,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: baseSize.width * 0.09,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: baseSize.width * 0.03,
                            ),
                            Opacity(
                              opacity: _progressBarErrorsLableAndTitleAppearing
                                  .value,
                              child: Text(
                                'Error',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: baseSize.width * 0.06),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedBuilder(
                          animation: _bottomSheetAnimationController,
                          builder: (BuildContext context, Widget child) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: (baseSize.height * 0.35) *
                                    _bottomSheetAnimation.value,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                  top: 25.0,
                                  left: 25.0,
                                  right: 25.0,
                                ),
                                child: SingleChildScrollView(
                                  physics: NeverScrollableScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () async {
                                            startAnimation();
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: baseSize.width * 0.02,
                                      ),
                                      Text(
                                        'Something went wrong',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: baseSize.width * 0.07,
                                        ),
                                      ),
                                      SizedBox(
                                        height: baseSize.width * 0.04,
                                      ),
                                      Text(
                                        'We couldn\'t process your request. Please try again.',
                                        style: TextStyle(
                                          fontSize: baseSize.width * 0.04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: baseSize.width * 0.08,
                                      ),
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        color: Colors.yellow,
                                        padding: EdgeInsets.only(
                                            left: 0.0, right: 0.0),
                                        onPressed: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          height: baseSize.height * 0.07,
                                          width: baseSize.width,
                                          child: Center(
                                            child: Text(
                                              'Try again',
                                              style: TextStyle(
                                                  fontSize:
                                                      baseSize.width * 0.05),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
    );
  }
}
