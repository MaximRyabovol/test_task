import 'package:flutter/material.dart';
import 'package:test_task/state_manager.dart';

import '../provider.dart';

class ErrorLabel extends StatefulWidget {
  ErrorLabel({Key key}) : super(key: key);

  @override
  _ErrorLabelState createState() => _ErrorLabelState();
}

class _ErrorLabelState extends State<ErrorLabel> with TickerProviderStateMixin {
  StateManager manager;

  AnimationController _progressBarAnimationController;
  Animation _progressBarAppearingAnimation;
  Animation _progressBarFillingAnimation;
  Animation _progressBarErrorsLableAndTitleAppearing;

  Size baseSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseSize = MediaQuery.of(context).size;

    manager = Provider.of(context);
    manager.initProgressBarAnimationController(this);

    _progressBarAnimationController = manager.progressBarAnimationController;

    _progressBarAppearingAnimation = manager.progressBarAppearingAnimation;

    _progressBarFillingAnimation = manager.progressBarFillingAnimation;

    _progressBarErrorsLableAndTitleAppearing =
        manager.progressBarErrorsLableAndTitleAppearing;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressBarAnimationController,
      builder: (BuildContext context, Widget child) {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Transform.rotate(
                    angle: 2.4,
                    child: Container(
                      width: (_progressBarAppearingAnimation.value *
                          (baseSize.width * 0.11)),
                      height: _progressBarAppearingAnimation.value *
                          (baseSize.width * 0.11),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Colors.white30,
                        value: _progressBarFillingAnimation.value,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: _progressBarErrorsLableAndTitleAppearing.value,
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
                opacity: _progressBarErrorsLableAndTitleAppearing.value,
                child: Text(
                  'Error',
                  style: TextStyle(
                      color: Colors.white, fontSize: baseSize.width * 0.06),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
