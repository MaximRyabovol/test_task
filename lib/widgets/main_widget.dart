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
  StateManager animationManager;

  Size baseSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animationManager = Provider.of(context);
    animationManager.initAnimation(this);

    baseSize = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    animationManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: FadeTransition(
          opacity: animationManager.mainWidgetFadeAnimation,
          child: GestureDetector(
            onTap: () => animationManager.startAnimation(),
            child: Container(
              color: Color(0xFF272b3d),
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
