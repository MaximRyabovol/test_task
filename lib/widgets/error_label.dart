import 'package:flutter/material.dart';
import 'package:test_task/state_manager.dart';

import '../provider.dart';

class ErrorLabel extends StatefulWidget {
  ErrorLabel({Key key}) : super(key: key);

  @override
  _ErrorLabelState createState() => _ErrorLabelState();
}

class _ErrorLabelState extends State<ErrorLabel> {
  StateManager animationManager;

  Size baseSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseSize = MediaQuery.of(context).size;

    animationManager = Provider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationManager.progressBarAndErrorLabelAnimationController,
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
                      width: (animationManager
                              .progressBarAppearingAnimation.value *
                          (baseSize.width * 0.11)),
                      height:
                          animationManager.progressBarAppearingAnimation.value *
                              (baseSize.width * 0.11),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Colors.white30,
                        value:
                            animationManager.progressBarFillingAnimation.value,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: animationManager
                        .progressBarErrorsLableAndTitleAppearing.value,
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
                opacity: animationManager
                    .progressBarErrorsLableAndTitleAppearing.value,
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
