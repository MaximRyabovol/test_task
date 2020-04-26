import 'package:flutter/material.dart';
import 'package:test_task/provider.dart';
import 'package:test_task/state_manager.dart';
import 'package:test_task/widgets/custom_bottom_sheet.dart';
import 'package:test_task/widgets/error_label.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  StateManager manager;

  Animation _mainWidgetFadeAnimation;

  Size baseSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    manager = Provider.of(context);
    manager.initMainWidgetAnimation(this);

    _mainWidgetFadeAnimation = manager.mainWidgetFadeAnimation;
    baseSize = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    manager.dispose();
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
              manager.startAnimation();
            },
            child: Container(
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  ErrorLabel(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomBottomSheet(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
